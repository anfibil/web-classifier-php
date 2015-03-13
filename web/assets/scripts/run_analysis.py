import pymysql
import sys
import json
from time import sleep
import random

analysisID = sys.argv[1]

# Connect to the Database
db = pymysql.connect(host="localhost", user="root", passwd="", db="symfony")
cursor = db.cursor()


# Find the current analysis object in the results database
cursor.execute("SELECT * FROM ode_results WHERE id="+analysisID)
analysis = cursor.fetchone()

# Get all parameters from 'analysis' and run experiment
# TODO: Write code for that here
temp_result = json.dumps({'accuracy' : random.uniform(0, 1), 'auroc' : random.uniform(0, 1), 'precision' : random.uniform(0, 1), 'fmeasure' : random.uniform(0, 1), 'rmse' : random.uniform(0, 1), 'recall' : random.uniform(0, 1)})


# Update the entry in the database to reflect completion
sleep(15)
cursor.execute("UPDATE ode_results SET finished=1, result=\'"+temp_result+"\' WHERE id="+analysisID)
db.commit()

# Close connection with the database
cursor.close()
db.close()