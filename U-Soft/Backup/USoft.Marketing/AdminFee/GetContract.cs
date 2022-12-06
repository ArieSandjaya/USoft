using System;
using System.Web;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.Shared;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace USoft.Marketing.AdminFee
{
    public class GetContract
    {
        private static string _ContractNo;
        private static int _SaveState;
        public GetContract()
        { }
        public void getContract(string ContractNo,List<KeyValuePair<string, object>> myControl)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@contNo", ContractNo));
            SqlDataReader dr = sqlHandler.ExecuteAsDataReader("ADMINFEE_GET_FINANCING", ParameterCollection);
            SQLHelper sqlHelper = new SQLHelper();
            sqlHelper.GetSqlValue(myControl, dr);
        }
        public DataSet getContract(string contNo, int startRow, int maxRow)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@contNo", contNo));
                ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", startRow));
                ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", maxRow));
                ParameterCollection.Add(new KeyValuePair<string, object>("@type", 0));
                return sqlHandler.ExecuteAsDataSet("ADMINFEE_GET_CONTRACT", ParameterCollection);
            }
            catch
            {
                return null;
            }
        }
        public Int32 getContractCount(string contNo)
        {
            int Total = 0;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@contNo", contNo));
            ParameterCollection.Add(new KeyValuePair<string, object>("@startRowIndex", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@maximumRows", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@type", 1));
            SqlDataReader sDr;
            sDr = sqlHandler.ExecuteAsDataReader("ADMINFEE_GET_CONTRACT", ParameterCollection);
            while (sDr.Read())
            {
                Total = Convert.ToInt32(sDr[0].ToString());
            }
            return Total;
        }
        public int SaveState
        {
            get
            {
                return _SaveState;
            }
            set
            {
                _SaveState = value;
            }
        }
        public string ContractNo
        {
            get
            {
                return _ContractNo;
            }
            set
            {
                _ContractNo = value;
            }
        }
    }
}
