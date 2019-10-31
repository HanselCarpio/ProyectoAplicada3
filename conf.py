import pymssql
import psycopg2
#import sqlite3
#from sqlite3 import Error

#ConnectionToSQL
_sql_server = "localhost"
_sql_database = "aplicada"
_sql_server_port = 1433
_sql_user = "hansel"
_sql_password = "1607"

#ConnectionToPostGreSQL
_postgre_server = "localhost"
_postgre_database = "B40425_aplicada"
_postgre_server_port = 51621
_postgre_user = "postgres"
_postgre_password = "hCarpio.16"

#SQL Connection
def mssql_connection():
    try:
        cnx = pymssql.connect(server=_sql_server, port=_sql_server_port,
                            user=_sql_user, password=_sql_password,database=_sql_database)
        return cnx
    except:
        print('Error: MSSQL Connection')

# Postgre Connection
def postgreSQL_Connection():
    try:
        cnx = psycopg2.connect("host="+_postgre_server+" dbname="+_postgre_database+" user="+_postgre_user+" password="+_postgre_password)

        return cnx
    except:
        print('Error: PostgreSQL Connection')

def get_data_from_sql(sp,table_name,firtsDate,SecondDate):
    try:
        con = mssql_connection()
        cur = con.cursor()
        cur.execute(("execute {} '" + table_name + "', '" + firtsDate +"', '" + SecondDate + "'").format(sp))
        data_return = cur.fetchall()
        con.commit()

        return data_return
    except IOError as e:
        print("Error {0} Getting data from SQL Server: {1}".format(
            e.errno, e.strerror))


def delete_clients_ordernumbers_creditcard(table_name):
    try:
        #Variables para llamar procedimiento almacenado
        sp = 'EX.spDeleteClientsOrderNumberCreditcard'
        con = mssql_connection()
        cur = con.cursor()
        cur.execute(("execute {} '" + table_name + "'").format(sp))
        con.commit()
    except IOError as e:
        print("Error {0} Getting data from SQL Server: {1}".format(
            e.errno, e.strerror))