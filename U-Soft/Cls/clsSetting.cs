using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using USoft.Common.Shared;

namespace USoft.Cls
{
    public class clsSetting
    {
        private static string _insType;

        public DataSet getCC()
        {
            string BranchId = HttpContext.Current.Session["BranchId"].ToString();
            
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@BranchId", BranchId));

            DataSet ds = new DataSet();
            SQLHandler sHand = new SQLHandler();            

            if (InsType.ToUpper() == "RAKSA")
            {
                ds = sHand.ExecuteAsDataSet("b2b_sendMail_Raksa", ParameterCollection);
            }
            else if (InsType.ToUpper() == "ASWATA")
            {
                ds = sHand.ExecuteAsDataSet("b2b_sendMail_Aswata", ParameterCollection);
            }
            else
            {
                ds = sHand.ExecuteAsDataSet("b2b_sendMail_Tokio", ParameterCollection);
            }

            return ds;
        }


        public string InsType
        {
            get
            { return _insType; }
            set
            { _insType = value; }
        }
    }
}
