import pymysql
import sys
import json
import ast
import random
import pandas as pd
import numpy as np
import timeit

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
cursor.execute("SELECT * FROM ode_dataset WHERE id="+str(analysis[6]))
dataset = cursor.fetchone()

######################
# Running Experiment #
######################

from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import Perceptron
from sklearn import cross_validation
from sklearn.metrics import roc_curve, auc
from sklearn import preprocessing
from scipy import interp

# Declare all classifiers (note that the keys here map to the keys on ode_models)
clfs = {
            1 : DecisionTreeClassifier(),
            2 : GaussianNB(),
            3 : Perceptron()
        }

# Grab correct classifier and set the parameters based on what the user specified 
if (analysis[2]):
	clf = clfs[analysis[1]].set_params(**ast.literal_eval(analysis[2]))
else:
	clf = clfs[analysis[1]] 

# Read and pre-process data
df = pd.read_csv(currentDir+'../datasets/'+dataset[7]+'.csv')
y = preprocessing.LabelEncoder().fit_transform(df.ix[:,df.shape[1]-1].values)
X = df.drop(df.columns[df.shape[1]-1], axis=1).values

# Run 10-fold cross validation and compute AUROC
mean_tpr = 0.0
mean_fpr = np.linspace(0, 1, 100)
skf = cross_validation.StratifiedKFold(y, n_folds=10)

for train_index, test_index in skf:
    probas_ = clf.fit(X[train_index], y[train_index]).predict_proba(X[test_index])
    
    # Compute ROC curve and area the curve
    fpr, tpr, thresholds = roc_curve(y[test_index], probas_[:, 1])
    mean_tpr += interp(mean_fpr, fpr, tpr)
    mean_tpr[0] = 0.0
    
mean_tpr /= len(skf)
mean_tpr[-1] = 1.0
mean_auc = auc(mean_fpr, mean_tpr)


##################################
# Saving Results to the database #
##################################

#temp_result = json.dumps({'accuracy' : random.uniform(0, 1), 'auroc' : random.uniform(0, 1), 'precision' : random.uniform(0, 1), 'fmeasure' : random.uniform(0, 1), 'rmse' : random.uniform(0, 1), 'recall' : random.uniform(0, 1)})
result = json.dumps({'auroc' : mean_auc})

# Update the entry in the database to reflect completion
stop = timeit.default_timer()
cursor.execute("UPDATE ode_results SET finished=1, runtime="+str(stop-start)+", result=\'"+result+"\' WHERE id="+analysisID)
db.commit()

# Close connection with the database
cursor.close()
db.close()