using System;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Data.SqlClient;
using System.Data.Common;
using Microsoft.VisualBasic;
using System.Data;
using USoft.Common.Setting;

namespace USoft.Common.Shared
{
    public class SQLHandler
    {
        #region "Private Member"
        private string _connectionString = SystemSetting.ConnectionString;
        #endregion

        #region "Properties"

        public string connectionString
        {
            get { return _connectionString; }
            set { _connectionString = value; }
        }

        #endregion

        #region "Transactions"

        public void CommitTransaction(DbTransaction transaction)
        {
            try
            {
                transaction.Commit();
            }
            catch
            {
                if (transaction != null && transaction.Connection != null)
                {
                    transaction.Connection.Close();
                }
            }
        }

        public DbTransaction GetTransaction()
        {
            SqlConnection Conn = new SqlConnection(this.connectionString);
            Conn.Open();
            SqlTransaction transaction = Conn.BeginTransaction();
            return transaction;
        }

        public void RollbackTransaction(DbTransaction transaction)
        {
            try
            {
                transaction.Rollback();
            }
            finally
            {
                if (transaction != null && transaction.Connection != null)
                {
                    transaction.Connection.Close();
                }
            }

        }

            #region "Using Transaction Method"
                public static void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText)
                {
                    if (connection.State != ConnectionState.Open)
                    {
                        connection.Open();
                    }
                    command.Connection = connection;
                    command.Transaction = transaction;
                    command.CommandType = commandType;
                    command.CommandText = commandText;
                    return;
                }

                // ExecuteNonQueryWithOutputParameter
                public int ExecuteNonQuery(SqlTransaction transaction, CommandType commandType, string commandText, List<KeyValuePair<string, object>> parameterCollection, string outParamName)
                {
                    SqlCommand cmd = new SqlCommand();
                    PrepareCommand(cmd, transaction.Connection, transaction, commandType,commandText);

                    for (int i = 0; i < parameterCollection.Count; i++)
                    {
                        SqlParameter sqlParameter = new SqlParameter();
                        sqlParameter.IsNullable = true;
                        sqlParameter.ParameterName = parameterCollection[i].Key;
                        sqlParameter.Value = parameterCollection[i].Value;
                        cmd.Parameters.Add(sqlParameter);
                    }

                    cmd.Parameters.Add(new SqlParameter(outParamName, SqlDbType.Int));
                    cmd.Parameters[outParamName].Direction = ParameterDirection.Output;

                    cmd.ExecuteNonQuery();
                    int id = (int)cmd.Parameters[outParamName].Value;

                    cmd.Parameters.Clear();
                    return id;
                }

                // ExecuteNonQueryWithoutOutPutParameter
                public void ExecuteNonQuery(SqlTransaction transaction,CommandType commandType,string commandText,List<KeyValuePair<string,object>> ParameterCollection)
                {
                    SqlCommand cmd = new SqlCommand();
                    PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText);

                    for (int i = 0; i < ParameterCollection.Count; i++)
                    {
                        SqlParameter sqlParameter = new SqlParameter();
                        sqlParameter.IsNullable = true;
                        sqlParameter.ParameterName = ParameterCollection[i].Key;
                        sqlParameter.Value = ParameterCollection[i].Value;
                        cmd.Parameters.Add(sqlParameter);
                    }

                    cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                }
            #endregion
        #endregion

        public bool ExecuteNonQueryAsBool(string StoredProcedureName, List<KeyValuePair<string,object>> ParameterCollection, string outputParameterName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.IsNullable = true;
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }

                cmd.Parameters.Add(new SqlParameter(outputParameterName,SqlDbType.Bit));
                cmd.Parameters[outputParameterName].Direction= ParameterDirection.Output;

                Conn.Open();
                cmd.ExecuteNonQuery();

                bool returnValue = (bool)cmd.Parameters[outputParameterName].Value;

                return returnValue;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public bool ExecuteNonQueryAsBool(string StoredProcedureName, List<KeyValuePair<string, object>> ParameterCollection, string outputParameterName, object outputParameterValue)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = StoredProcedureName;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.IsNullable = true;
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }

                cmd.Parameters.Add(new SqlParameter(outputParameterName,SqlDbType.Bit));
                cmd.Parameters[outputParameterName].Direction = ParameterDirection.Output;
                cmd.Parameters[outputParameterName].Value = outputParameterValue;

                Conn.Open();
                cmd.ExecuteNonQuery();

                bool ReturnValue = (bool)cmd.Parameters[outputParameterName].Value;

                return ReturnValue;
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public void ExecuteNonQuery(string StoredProcedureName, List<KeyValuePair<string, object>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.IsNullable = true;
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }

                Conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public void ExecuteNonQuery(string StoredProcedureName, List<KeyValuePair<string, string>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    cmd.Parameters.Add(new SqlParameter(ParameterCollection[i].Key,ParameterCollection[i].Key));
                }

                Conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public void ExecuteNonQuery(string StoredProcedureName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public int ExecuteNonQuery(string StoredProcedureName, List<KeyValuePair<string,object>> ParameterCollection, string outputParameterName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.IsNullable = true;
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }

                cmd.Parameters.Add(new SqlParameter(outputParameterName,SqlDbType.Int));
                cmd.Parameters[outputParameterName].Direction= ParameterDirection.Output;

                Conn.Open();
                cmd.ExecuteNonQuery();

                int returnValue = (int)cmd.Parameters[outputParameterName].Value;

                return returnValue;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public int ExecuteNonQuery(string StoredProcedureName, List<KeyValuePair<string,string>> ParameterCollection, string outputParameterName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    cmd.Parameters.Add(new SqlParameter(ParameterCollection[i].Key,ParameterCollection[i].Value));
                }

                cmd.Parameters.Add(new SqlParameter(outputParameterName,SqlDbType.Int));
                cmd.Parameters[outputParameterName].Direction= ParameterDirection.Output;

                Conn.Open();
                cmd.ExecuteNonQuery();

                int returnValue = (int)cmd.Parameters[outputParameterName].Value;

                return returnValue;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public int ExecuteNonQuery(string StoredProcedureName, List<KeyValuePair<string, string>> ParameterCollection, string outputParameterName, object outputParameterValue)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = StoredProcedureName;

                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.IsNullable = true;
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }

                cmd.Parameters.Add(new SqlParameter(outputParameterName, SqlDbType.Int));
                cmd.Parameters[outputParameterName].Direction = ParameterDirection.Output;
                cmd.Parameters[outputParameterName].Value = outputParameterValue;

                Conn.Open();
                cmd.ExecuteNonQuery();

                int ReturnValue = (int)cmd.Parameters[outputParameterName].Value;

                return ReturnValue;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public int ExecuteNonQuery(string StoredProcedureName,string outputParameterName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter(outputParameterName,SqlDbType.Int));
                cmd.Parameters[outputParameterName].Direction= ParameterDirection.Output;

                Conn.Open();
                cmd.ExecuteNonQuery();

                int returnValue = (int)cmd.Parameters[outputParameterName].Value;

                return returnValue;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public int ExecuteNonQuery(string StoredProcedureName, string outputParameterName, object outputParameterValue)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = Conn;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = StoredProcedureName;

                cmd.Parameters.Add(new SqlParameter(outputParameterName, SqlDbType.Int));
                cmd.Parameters[outputParameterName].Direction = ParameterDirection.Output;
                cmd.Parameters[outputParameterName].Value = outputParameterValue;

                Conn.Open();
                cmd.ExecuteNonQuery();

                int ReturnValue = (int)cmd.Parameters[outputParameterName].Value;

                return ReturnValue;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }
        }

        public DataSet ExecuteAsDataSet(string StoredProcedureName)
        {
            try
            {
                SqlConnection Conn = new SqlConnection(this._connectionString);
                SqlDataAdapter sDa = new SqlDataAdapter();
                DataSet ds = new DataSet();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                //cmd.CommandType = CommandType.StoredProcedure;    // mark by dwi 20130516
                cmd.Connection = Conn;
                Conn.Open();
                SqlDataReader sDr;
                sDr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                ds.Load(sDr, LoadOption.Upsert, StoredProcedureName);

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet ExecuteAsDataSet(string StoredProcedureName, List<KeyValuePair<string, object>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                for (int i=0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }
                SqlDataReader sDr = cmd.ExecuteReader();
                DataSet ds = new DataSet();
                ds.Load(sDr, LoadOption.Upsert,StoredProcedureName);

                return ds;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }

        }

        public DataSet ExecuteAsDataSet(string StoredProcedureName, List<KeyValuePair<string, string>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                //SqlDataAdapter sDA = new SqlDataAdapter();
                DataSet ds = new DataSet();

                for (int i = 0; i < ParameterCollection.Count; i++)
                {
                    cmd.Parameters.Add(new SqlParameter(ParameterCollection[i].Key,ParameterCollection[i].Value));
                }
                SqlDataReader sDr;
                sDr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                ds.Load(sDr, LoadOption.Upsert, StoredProcedureName);
                return ds;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }

        }

        public DataSet ExecuteAsDataSet(string StoredProcedureName, ref List<SqlParameter> ListParam)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                foreach (SqlParameter sqlParam in ListParam)
                {
                    cmd.Parameters.Add(sqlParam);
                }
                
                SqlDataReader sDr = cmd.ExecuteReader();
                DataSet ds = new DataSet();
                ds.Load(sDr, LoadOption.Upsert, StoredProcedureName);

                // Output Return
                foreach (SqlParameter sqlParam in ListParam)
                {
                    sqlParam.Value = cmd.Parameters[sqlParam.ParameterName].Value;
                }

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }

        }

        public SqlDataReader ExecuteAsDataReader(string StoredProcedureName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlDataReader dr;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                return dr;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader ExecuteAsDataReader(string StoredProcedureName,List<KeyValuePair<string,object>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlDataReader dr;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                for (int i = 0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.IsNullable = true;
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                return dr;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SqlDataReader ExecuteAsDataReader(string StoredProcedureName, List<KeyValuePair<string, string>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);

            try
            {
                SqlDataReader dr;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                for (int i = 0; i < ParameterCollection.Count; i++)
                {
                    cmd.Parameters.Add(new SqlParameter(ParameterCollection[i].Key,ParameterCollection[i].Value));
                }
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                return dr;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable ExecuteAsDataTable(string StoredProcedureName)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                DataTable dt = new DataTable();
                dt.BeginLoadData();
                dt.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection), LoadOption.Upsert);
                dt.EndLoadData();
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataTable ExecuteAsDataTable(string StoredProcedureName, List<KeyValuePair<string, object>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                for (int i = 0; i < ParameterCollection.Count; i++)
                {
                    SqlParameter parameter = new SqlParameter();
                    parameter.ParameterName = ParameterCollection[i].Key;
                    parameter.Value = ParameterCollection[i].Value;
                    cmd.Parameters.Add(parameter);
                }
                DataTable dt = new DataTable();
                dt.BeginLoadData();
                dt.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection), LoadOption.Upsert);
                dt.EndLoadData();
                return dt;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }

        }

        public DataTable ExecuteAsDataTable(string StoredProcedureName, List<KeyValuePair<string, string>> ParameterCollection)
        {
            SqlConnection Conn = new SqlConnection(this._connectionString);
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = StoredProcedureName;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = Conn;
                Conn.Open();
                SqlDataAdapter sDA = new SqlDataAdapter();
                DataSet ds = new DataSet();

                for (int i = 0; i < ParameterCollection.Count; i++)
                {
                    cmd.Parameters.Add(new SqlParameter(ParameterCollection[i].Key, ParameterCollection[i].Value));
                }

                DataTable dt = new DataTable();
                dt.BeginLoadData();
                dt.Load(cmd.ExecuteReader(CommandBehavior.CloseConnection), LoadOption.Upsert);
                dt.EndLoadData();
                return dt;

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                Conn.Close();
            }

        }
    }
}
