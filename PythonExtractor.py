import sys 
import time
import csv
import datetime

from conf import mssql_connection,get_data_from_sql
from PythonLoader import upload_csv_file_to_postgre


def extractor():
    try:
        print("Running Extractor...")

        #Variables para llamar procedimiento almacenado 
        query = 'EX.spExtractor'
        tableName = 'CLIENT'
        firtsDate = '2019-01-01'
        secondDate = '2020-04-04'

        # SQL Server Connection
        con_sql = mssql_connection()

        data = get_data_from_sql(query,tableName,firtsDate,secondDate)

        if(len(data) == 0):
            print('No data retrieved')
            sys.exit(0)
        else:
            access = "w"
            newline = {"newline": ""}
            datetime_object = datetime.datetime.now().strftime("%d-%m-%Y %H;%M;%S")
            fileName = str(tableName) + " _B40425(" + str(datetime_object) + ").csv"
            print("Getting Data from SQLServer...")
            with open(fileName,access, **newline) as outfile:
                writer = csv.writer(outfile, quoting=csv.QUOTE_NONNUMERIC)
                if(tableName == 'CLIENT'):
                    writer.writerow(
                        ["ID","NAME","PERSONAL_ID"])
                else:
                    writer.writerow(
                    ["CLIENT_ID",tableName])
                for row in data:
                    print(row)
                    writer.writerow(row)
            print("Extractor Done.")
            print("Running Loader...")
            upload_csv_file_to_postgre(tableName,fileName)
    except IOError as e:
        print("Error: {0} Getting data from MSSQL: {1}".format(      
            e.errno,e.strerror))
    finally:
        con_sql.close()

extractor()