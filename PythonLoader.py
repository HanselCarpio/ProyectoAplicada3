import psycopg2
import pandas as pd
import sys
import datetime
import time

from conf import postgreSQL_Connection, delete_clients_ordernumbers_creditcard

def upload_csv_file_to_postgre(table,fileName):
    try:
        if(table == 'CLIENT'):
            table_name = 'actual.' + table
        else:
            table_name = 'actual.' + table

        con_postgre = postgreSQL_Connection()
        print("Connecting to PostGreSQL Database")
        cur = con_postgre.cursor()
        print("Loading data from SQLServer...")
        with open(fileName, 'r') as f:

            next(f)
            cur.copy_from(f, table_name, sep=',')
            con_postgre.commit()
        
        #si el usuario migra las tablas cliente, numero de orden o tarjeta de credito
        if(table == 'CLIENT' or table == 'ORDERNUMBER' or table == 'CREDITCARD'):
            print("Deleting data from SQLServer...")
            delete_clients_ordernumbers_creditcard(table)



    except IOError as e:
        print("Error: {0} Uploading data to PostgreSQL: {1}".format(
            e.errno, e.strerror))
    finally:
        con_postgre.close()
        print("PostGreSQL DB connection closed.")
        print("EXTRACTOR AND LOADER DONE SUCCESFULLY.")


