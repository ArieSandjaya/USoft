using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.Master
{
    public class Supplier : USoft.DataAccess.General.Common
    {
        // Parameter
        string povchSupplierCode = "@povchSupplierCode";
        string pivchSupplierCode = "@pivchSupplierCode";
        string pivchSupplierName = "@pivchSupplierName";
        string pivchAddress = "@pivchAddress";
        string pivchCity = "@pivchCity";
        string pivchZipCode = "@pivchZipCode";
        string pivchPhone = "@pivchPhone";
        string pivchNPWP = "@pivchNPWP";
        string pivchState = "@pivchState";

        // Store Procedure
        string spSupplierList = "spSupplierList";
        string spSupplierInsert = "spSupplierInsert";
        string spSupplierUpdate = "spSupplierUpdate";
        string spSupplierView = "spSupplierView";

        // Field Name
        string SupplierCode = "SupplierCode";
        string SupplierName = "SupplierName";
        string Address = "Address";
        string City = "City";
        string ZipCode = "ZipCode";
        string Phone = "Phone";
        string NPWP = "NPWP";

        public DataSet getSupplier(ref USoft.DataAccess.Entities.Master.Supplier info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchWhereBy;
            sqlParam.Value = info.WhereBy;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintPageNo;
            sqlParam.Value = info.PageNo;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = piintPageSize;
            sqlParam.Value = info.PageSize;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointTotalPage;
            sqlParam.Value = info.TotalPage;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pointTotalData;
            sqlParam.Value = info.TotalData;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            try
            {
                ds = sqlHandler.ExecuteAsDataSet(spSupplierList, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == pointTotalPage) { info.TotalPage = Convert.ToInt32(sqlParamOut.Value); continue; }
                    if (sqlParamOut.ParameterName == pointTotalData) { info.TotalData = Convert.ToInt32(sqlParamOut.Value); continue; }
                }
                return ds;
            }
            catch
            { throw; }
        }

        public String SupplierInsert(ref USoft.DataAccess.Entities.Master.Supplier info)
        {
            DataSet ds = new DataSet();
            SQLHandler sqlHandler = new SQLHandler();
            List<SqlParameter> ListParam = new List<SqlParameter>();
            SqlParameter sqlParam;
            String sqlMsg;

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = povchSupplierCode;
            sqlParam.Value = info.SupplierCode;
            sqlParam.Size = 12;
            sqlParam.Direction = ParameterDirection.Output;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchSupplierName;
            sqlParam.Value = info.SupplierName;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchAddress;
            sqlParam.Value = info.Address;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchCity;
            sqlParam.Value = info.City;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchZipCode;
            sqlParam.Value = info.ZipCode;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchPhone;
            sqlParam.Value = info.Phone;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchNPWP;
            sqlParam.Value = info.NPWP;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pibitIsActive;
            sqlParam.Value = info.IsActive;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchState;
            sqlParam.Value = info.State;
            ListParam.Add(sqlParam);

            sqlParam = new SqlParameter();
            sqlParam.ParameterName = pivchInputID;
            sqlParam.Value = info.InputBy;
            ListParam.Add(sqlParam);

            try
            {
                sqlHandler.ExecuteAsDataSet(spSupplierInsert, ref ListParam);
                foreach (SqlParameter sqlParamOut in ListParam)
                {
                    if (sqlParamOut.ParameterName == povchSupplierCode) { info.SupplierCode = sqlParamOut.Value.ToString(); continue; }
                }
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String SupplierUpdate(USoft.DataAccess.Entities.Master.Supplier info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierName, info.SupplierName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchAddress, info.Address));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchCity, info.City));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchZipCode, info.ZipCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPhone, info.Phone));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchNPWP, info.NPWP));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchState, info.State));
            ParameterCollection.Add(new KeyValuePair<string, object>(pibitIsActive, info.IsActive));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spSupplierUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public void getSupplierView(ref USoft.DataAccess.Entities.Master.Supplier info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchSupplierCode, info.SupplierCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spSupplierView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.SupplierName = dr[SupplierName].ToString();
                        info.Address = dr[Address].ToString();
                        info.City = dr[City].ToString();
                        info.ZipCode = dr[ZipCode].ToString();
                        info.Phone = dr[Phone].ToString();
                        info.NPWP = dr[NPWP].ToString();
                        info.IsActive = Convert.ToBoolean(dr[IsActive].ToString());
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }
    }
}
