import pymysql
import sys
import json
import ast
import pandas as pd
import numpy as np
import timeit
import re
import random
import patsy

#######################
# Parameter Retrieval #
#######################

start = timeit.default_timer()

analysisID = sys.argv[1]
currentDir = sys.argv[2]

# Connect to the Database
db = pymysql.connect(host="localhost", user="root", passwd="", db="symfony")
cursor = db.cursor()

# Find the current analysis object in the results database
cursor.execute("SELECT dataset_id, preprocessing_params, params, model_id  FROM ode_results WHERE id="+analysisID)
analysis = cursor.fetchone()

# Find the dataset to be used by the current analysis
cursor.execute("SELECT * FROM ode_dataset WHERE id="+str(analysis[0]))
dataset = cursor.fetchone()


#################################
# Data Pre-processing Functions #
#################################

from sklearn.neighbors import NearestNeighbors

preprocessing_params = json.loads(analysis[1])


def undersample(x, y, ix, subsampling_rate=1.0):
    """ Data undersampling.
    
    This function takes in a list or array indexes that will be used for training
    and it performs subsampling in the majority class (c == 0) to enforce a certain ratio
    between the two classes
    Parameters
    ----------
    x : np.ndarray
        The entire dataset as a ndarray
    y : np.ndarray
        The labels
    ix : np.ndarray
        The array indexes for the instances that will be used for training
    subsampling_rate : float
        The desired percentage of majority instances in the subsample
    
    Returns
    --------
    np.ndarray 
        The new list of array indexes to be used for training
    """

    # Get indexes of instances that belong to classes 0 and 1
    indexes_0 = [item for item in ix if y[item] == 0]
    indexes_1 = [item for item in ix if y[item] == 1]

    # Determine how large the new majority class set should be
    sample_length = int(len(indexes_0)*subsampling_rate)
    sample_indexes = random.sample(indexes_0, sample_length) + indexes_1

    return sample_indexes

def SMOTE(T, N, k, h = 1.0):
    """ Synthetic minority oversampling.
    Returns (N/100) * n_minority_samples synthetic minority samples.
    Parameters
    ----------
    T : array-like, shape = [n_minority_samples, n_features]
        Holds the minority samples
    N : percetange of new synthetic samples: 
        n_synthetic_samples = N/100 * n_minority_samples. Can be < 100.
    k : int. Number of nearest neighbours. 
    Returns
    -------
    S : Synthetic samples. array, 
        shape = [(N/100) * n_minority_samples, n_features]. 
    """    
    n_minority_samples, n_features = T.shape
    
    if N < 100:
        #create synthetic samples only for a subset of T.
        #TODO: select random minortiy samples
        N = 100
        pass

    if (N % 100) != 0:
        raise ValueError("N must be < 100 or multiple of 100")
    
    N = N/100
    n_synthetic_samples = N * n_minority_samples
    S = np.zeros(shape=(n_synthetic_samples, n_features))
    
    #Learn nearest neighbours
    neigh = NearestNeighbors(n_neighbors = k)
    neigh.fit(T)
    
    #Calculate synthetic samples
    for i in xrange(n_minority_samples):
        nn = neigh.kneighbors(T[i], return_distance=False)
        for n in xrange(N):
            nn_index = random.choice(nn[0])
            #NOTE: nn includes T[i], we don't want to select it 
            while nn_index == i:
                nn_index = random.choice(nn[0])
                
            dif = T[nn_index] - T[i]
            gap = np.random.uniform(low = 0.0, high = h)
            S[n + i * N, :] = T[i,:] + gap * dif[:]
    
    return S

#########################################
# Retrieving dataset and pre-processing #
#########################################

from sklearn import preprocessing, decomposition
from scipy import stats

df = pd.read_csv(currentDir+'../datasets/'+dataset[7]+'.csv')
y = preprocessing.LabelEncoder().fit_transform(df.ix[:,df.shape[1]-1].values)
X = df.drop(df.columns[df.shape[1]-1], axis=1)

# Fill in missing values
if (preprocessing_params['missing_data'] == 'default'):
    X = X.fillna(-1)
elif(preprocessing_params['missing_data'] == 'average'):
    X = X.fillna(X.mean())
elif (preprocessing_params['missing_data'] == 'interpolation'):
    X = X.interpolate()

s = ' + '.join(X.columns) + ' -1' 
# Note: The encoding below could create very large dataframes for datasets with many categorical features.
X = patsy.dmatrix(s, X, return_type='dataframe').values


# Remove outliers
# TODO: Move this to traning step of K-fold so as to keep test untouched?
if preprocessing_params['outlier_detection']:
    non_outlier_idx = (np.abs(stats.zscore(X)) < 3).all(axis=1)
    X = X[non_outlier_idx]
    y = y[non_outlier_idx]

# Perform standardization. TODO: Should this come before encoding?
if preprocessing_params['standardization']:
    X = preprocessing.scale(X)

# Perform normalization. TODO: Check to make sure order doesn't matter
if preprocessing_params['normalization']:
    X = preprocessing.normalize(X, norm=preprocessing_params['norm'])

# Perform binarization. TODO: Check to make sure order doesn't matter
if preprocessing_params['binarization']:
    binarizer = preprocessing.Binarizer(threshold=preprocessing_params['binarization_threshold']).fit(X)
    X = binarizer.transform(X)

# Apply PCA
if preprocessing_params['pca']:
    estimator = decomposition.PCA(n_components=preprocessing_params['n_components'])
    X = estimator.fit_transform(X)

######################
# Running Experiment #
######################

from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import LogisticRegression, SGDClassifier
from sklearn import cross_validation
from scipy import interp
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.metrics import *

# Declare all classifiers (note that the keys here map to the keys on ode_models)
clfs = {
            1 : DecisionTreeClassifier(),
            2 : GaussianNB(),
            3 : KNeighborsClassifier(),
            4 : LogisticRegression(),
            5 : SVC(),
            6 : SGDClassifier()
        }

model_params = ast.literal_eval(analysis[2])

# This seems necessary to avoid "shuffle must be True or False error when using SGDClassifier"
if (analysis[3] == 6):
    model_params['shuffle'] = bool(model_params['shuffle'])

# Grab correct classifier and set the parameters based on what the user specified 
if (analysis[2]):
	clf = clfs[analysis[3]].set_params(**model_params)
else:
	clf = clfs[analysis[3]] 

# Run 10-fold cross validation and compute AUROC
mean_tpr = 0.0
mean_fpr = np.linspace(0, 1, 100)
y_prob = []
y_pred = []
indexes = []
y_original_values = []
skf = cross_validation.StratifiedKFold(y, n_folds=10)


from scipy.stats import itemfreq
for train_index, test_index in skf:
    
    if preprocessing_params['undersampling']:
        train_index = undersample(X,y,train_index,float(preprocessing_params['undersampling_rate'])/100)

    X_train = X[train_index]
    y_train = y[train_index]

    if preprocessing_params['oversampling']:
        minority = X_train[np.where(y_train==1)]
        smotted = SMOTE(minority, preprocessing_params['undersampling_rate'], 5)
        X_train = np.vstack((X_train,smotted))
        y_train = np.append(y_train,np.ones(len(smotted),dtype=np.int32))          

    clf.fit(X_train, y_train)        
    probas_ = clf.predict_proba(X[test_index])
    preds_ = clf.predict(X[test_index])
    
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
auroc = auc(mean_fpr, mean_tpr)

# Compute precision,recall curve points and area under PR-curve
precision, recall, thresholds = precision_recall_curve(y_original_values, y_prob)
aupr = auc(recall, precision)

# Store a flag for mispredictions
errors = np.logical_xor(y_pred,y_original_values).astype(int)

# Compute overall accuracy
accuracy = 1- (np.sum(errors)/float(len(errors)))

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

# Compute precision, recall and f1-score
precision, recall, f1_score, support = precision_recall_fscore_support(y_original_values, y_pred)

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

report_data = json.dumps({'roc_points':roc_points, 'prc_points':prc_points, 'confusion_matrix':confusion_matrix, 'classification_report':clf_report, 'indexes':indexes, 'y_original_values':y_original_values, 'y_pred':y_pred, 'y_prob':y_prob,'errors':errors})

# Update the entry in the database to reflect completion
stop = timeit.default_timer()
cursor.execute("UPDATE ode_results SET finished=1, runtime="+str(stop-start)+", aupr="+str(aupr)+", auroc="+str(auroc)+", accuracy="+str(accuracy)+", precision_score="+str(precision[1])+", recall_score="+str(recall[1])+", f1_score="+str(f1_score[1])+", report_data=\'"+report_data+"\' WHERE id="+analysisID)
db.commit()

# Close connection with the database
cursor.close()
db.close()

