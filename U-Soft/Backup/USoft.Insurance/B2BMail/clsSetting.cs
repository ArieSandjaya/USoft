using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web;
using USoft.Common.Shared;

namespace USoft.Insurance.B2BMail
{
    public class clsSetting
    {
        private static string _insType;
        public DataSet getCC()
        {
            SQLHandler sHand = new SQLHandler();
            DataSet ds = new DataSet();
            string BranchId = HttpContext.Current.Session["BranchId"].ToString();
            
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@piintBranchId", BranchId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@pivchInsType", InsType));

            try
            {
                ds = sHand.ExecuteAsDataSet("spB2BSendMail", ParameterCollection);
            }
            catch
            {
                throw;
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
