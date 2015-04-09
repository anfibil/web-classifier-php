import pymysql
import sys
import json
import ast
import random
import pandas as pd
import numpy as np
import timeit
import re
import patsy

#################################
# Retrieving data from database #
#################################

start = timeit.default_timer()

analysisID = sys.argv[1]
currentDir = sys.argv[2]

# Connect to the Database
db = pymysql.connect(host="localhost", user="root", passwd="", db="symfony")
cursor = db.cursor()

# Find the current analysis object in the results database
cursor.execute("SELECT * FROM ode_results WHERE id="+analysisID)
analysis = cursor.fetchone()

# Find the dataset to be used by the current analysis
print analysis
cursor.execute("SELECT * FROM ode_dataset WHERE id="+str(analysis[5]))
dataset = cursor.fetchone()

######################
# Running Experiment #
######################

from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import Perceptron
from sklearn import cross_validation
from sklearn.metrics import roc_curve, auc, precision_recall_curve, confusion_matrix, classification_report
from sklearn import preprocessing
from scipy import interp

# Declare all classifiers (note that the keys here map to the keys on ode_models)
clfs = {
            1 : DecisionTreeClassifier(),
            2 : GaussianNB(),
            3 : Perceptron()
        }

# Grab correct classifier and set the parameters based on what the user specified 
if (analysis[1]):
	clf = clfs[analysis[7]].set_params(**ast.literal_eval(analysis[1]))
else:
	clf = clfs[analysis[7]] 

# Read and pre-process data
df = pd.read_csv(currentDir+'../datasets/'+dataset[7]+'.csv')
y = preprocessing.LabelEncoder().fit_transform(df.ix[:,df.shape[1]-1].values)
X = df.drop(df.columns[df.shape[1]-1], axis=1)
s = ' + '.join(X.columns) + ' -1' 
X = patsy.dmatrix(s, X, return_type='dataframe').values

# Run 10-fold cross validation and compute AUROC
mean_tpr = 0.0
mean_fpr = np.linspace(0, 1, 100)
y_prob = []
y_pred = []
indexes = []
y_original_values = []
skf = cross_validation.StratifiedKFold(y, n_folds=10)

for train_index, test_index in skf:
    probas_ = clf.fit(X[train_index], y[train_index]).predict_proba(X[test_index])
    preds_ = clf.fit(X[train_index], y[train_index]).predict(X[test_index])
    
    # Compute ROC curve and area the curve
    fpr, tpr, thresholds = roc_curve(y[test_index], probas_[:, 1])

    mean_tpr += interp(mean_fpr, fpr, tpr)
    mean_tpr[0] = 0.0
    
    # Keep track of original y-values and corresponding predicted probabilities and values
    y_original_values = np.concatenate((y_original_values,y[test_index]),axis=0)
    y_prob = np.concatenate((y_prob,probas_[:, 1]),axis=0)
    y_pred = np.concatenate((y_pred,preds_),axis=0)
    indexes = np.concatenate((indexes,test_index),axis=0)
    

# Compute TPR and AUROC    
mean_tpr /= len(skf)
mean_tpr[-1] = 1.0
mean_auc = auc(mean_fpr, mean_tpr)

# Compute precision,recall curve points and area under PR-curve
precision, recall, thresholds = precision_recall_curve(y_original_values, y_prob)
aupr = auc(recall, precision)

# Store a flag for mispredictions
errors = np.logical_xor(y_pred,y_original_values).astype(int)

# Store xy coordinates of ROC curve points
roc_points = ''
for x in zip(mean_fpr,mean_tpr):
    roc_points += ('[' + str("%.3f" % x[0]) + ',' + str("%.3f" % x[1]) + '],')
roc_points = roc_points[:-1]

# Store xy coordinates of PR curve points
prc_points = ''
for x in zip(recall,precision):
    prc_points += ('[' + str("%.3f" % x[0]) + ',' + str("%.3f" % x[1]) + '],')
prc_points = prc_points[:-1]

# Store confusion matrix as a string with values separated by commas
confusion_matrix = str(confusion_matrix(y_original_values, y_pred).tolist()).replace(']',"").replace('[',"")

# Store a list of the numeric values returned by classification_report()
clf_report = re.sub(r'[^\d.]+', ', ', classification_report(y_original_values, y_pred))[5:-2]

# Limit the number of instances saved to DB so report won't crash
LAST_INDEX = 1000 if (len(indexes)>1000) else len(indexes)

# Sort everything by instance number
sorted_ix = np.argsort(indexes)
indexes = ','.join(str(e) for e in indexes[sorted_ix][:LAST_INDEX].astype(int))
y_original_values = ','.join(str(e) for e in y_original_values[sorted_ix][:LAST_INDEX].astype(int))
y_pred = ','.join(str(e) for e in y_pred[sorted_ix][:LAST_INDEX].astype(int))
errors = ','.join(str(e) for e in errors[sorted_ix][:LAST_INDEX]).replace('0'," ").replace('1',"&#x2717;")
y_prob = ','.join(str(e) for e in np.around(y_prob[sorted_ix][:LAST_INDEX], decimals=4))

##################################
# Saving Results to the database #
##################################

result = json.dumps({'auroc' : mean_auc, 'roc_points':roc_points, 'aupr' : aupr, 'prc_points':prc_points, 'confusion_matrix':confusion_matrix, 'classification_report':clf_report, 'indexes':indexes, 'y_original_values':y_original_values, 'y_pred':y_pred, 'y_prob':y_prob,'errors':errors})

# Update the entry in the database to reflect completion
stop = timeit.default_timer()
cursor.execute("UPDATE ode_results SET finished=1, runtime="+str(stop-start)+", result=\'"+result+"\', dataset_name=\'"+dataset[1]+"\' WHERE id="+analysisID)
db.commit()

# Close connection with the database
cursor.close()
db.close()
