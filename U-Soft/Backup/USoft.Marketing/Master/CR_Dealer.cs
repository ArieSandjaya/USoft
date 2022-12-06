using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data.SqlClient;
using System.Data;
using USoft.Common.CommonFunction;

namespace USoft.Marketing.Master
{
    public class CR_Dealer
    {
        public CR_Dealer()
        { }
        //showDealer
        public DataSet showMRDealer(string dealername, string brandname, string area)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@dealer_name", dealername));
                ParameterCollection.Add(new KeyValuePair<string, object>("@brand_name", brandname));
                ParameterCollection.Add(new KeyValuePair<string, object>("@area", area));
                return sqlHandler.ExecuteAsDataSet("CASH_REWARD_DEALER_SHOW", ParameterCollection);
            }
            catch
            { throw; }
        }
        //addDealer
        public Boolean MRAddNewDealer(string brandcode, string BrandName, string area, string DealerCode, string DealerName, decimal Amount, string UseArea, string UpdateBy)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandCode", brandcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandName", BrandName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Area", area));
                ParameterCollection.Add(new KeyValuePair<string, object>("@DealerCode", DealerCode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@DealerName", DealerName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Amount", Amount));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Use_Area", UseArea));
                ParameterCollection.Add(new KeyValuePair<string, object>("@UpdateBy", UpdateBy));
                sqlHandler.ExecuteNonQuery("CASH_REWARD_DEALER_CREATE", ParameterCollection);
                return true;
            }
            catch
            { return false; }
        }
        //editDealer
        public Boolean MRSaveEditDealer(int id, string brandcode, string BrandName, string area, string DealerCode, string DealerName, decimal Amount, string UseArea, string UpdateBy, string Active)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@id", id));
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandCode", brandcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandName", BrandName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Area", area));
                ParameterCollection.Add(new KeyValuePair<string, object>("@DealerCode", DealerCode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@DealerName", DealerName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Amount", Amount));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Use_Area", UseArea));
                ParameterCollection.Add(new KeyValuePair<string, object>("@UpdateBy", UpdateBy));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Active", Active));

                sqlHandler.ExecuteNonQuery("CASH_REWARD_DEALER_EDIT", ParameterCollection);
                return true;
            }
            catch
            { return false; }
        }
        //deleteDealer
        public Boolean MRDeleteDealer(int id)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@Id", id));

                sqlHandler.ExecuteNonQuery("CASH_REWARD_DEALER_DELETE", ParameterCollection);
                return true;
            }
            catch
            { return false; }
        }

        
    }
}
