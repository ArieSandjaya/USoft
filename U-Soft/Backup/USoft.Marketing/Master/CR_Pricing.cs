using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data.SqlClient;
using System.Data;
using USoft.Common.CommonFunction;

namespace USoft.Marketing.Master
{
    public class CR_Pricing
    {
        public CR_Pricing()
        { }
        //showPricing
        public DataSet getCRPricing(string brandCd, string area, string tenor)
        {
            try
            {   CommonFunction cf = new CommonFunction();
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandCode", brandCd));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Area", area));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Tenor", tenor));
                return sqlHandler.ExecuteAsDataSet("CASH_REWARD_PRICING_SHOW", ParameterCollection);
            }
            catch
            { throw; }
        }
        //addPricing
        public Boolean MRAddNewPricing(string type, string brandcode, string area, string tenor, decimal adminfee, decimal flatinputaddm, decimal flatinputaddb, string usearea, string UpdateBy)
        {
            try
            {   SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@Type", type));
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandCode", brandcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Area", area));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Tenor", tenor));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Adminfee", adminfee));
                ParameterCollection.Add(new KeyValuePair<string, object>("@FIAddm", flatinputaddm));
                ParameterCollection.Add(new KeyValuePair<string, object>("@FIAddb", flatinputaddb));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Use_Area", usearea));
                ParameterCollection.Add(new KeyValuePair<string, object>("@UpdateBy", UpdateBy));
                sqlHandler.ExecuteNonQuery("CASH_REWARD_PRICING_CREATE", ParameterCollection);
                return true;
            }
            catch
            {   return false; }
        }
        //editPricing
        public Boolean MRSaveEditPricing(string Wtype,string Wbrandcode,string Warea,int Wtenor,  string type, string brandcode, string area, string tenor, decimal adminfee, decimal flatinputaddm, decimal flatinputaddb, string usearea, string UpdateBy, string Active)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereType", Wtype));
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereBrandCode", Wbrandcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereArea", Warea));
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereTenor", Wtenor));

                ParameterCollection.Add(new KeyValuePair<string, object>("@Type", type));
                ParameterCollection.Add(new KeyValuePair<string, object>("@BrandCode", brandcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Area", area));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Tenor", tenor));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Adminfee", adminfee));
                ParameterCollection.Add(new KeyValuePair<string, object>("@FIAddm", flatinputaddm));
                ParameterCollection.Add(new KeyValuePair<string, object>("@FIAddb", flatinputaddb));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Use_Area", usearea));
                ParameterCollection.Add(new KeyValuePair<string, object>("@UpdateBy", UpdateBy));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Active", Active));
                sqlHandler.ExecuteNonQuery("CASH_REWARD_PRICING_EDIT", ParameterCollection);
                return true;
            }
            catch
            { return false; }
        }
        //deletePricing
        public Boolean MRDeletePricing(string Wtype, string Wbrandcode, string Warea, int Wtenor)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereType", Wtype));
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereBrandCode", Wbrandcode));
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereArea", Warea));
                ParameterCollection.Add(new KeyValuePair<string, object>("@WhereTenor", Wtenor));
                sqlHandler.ExecuteNonQuery("CASH_REWARD_PRICING_DELETE", ParameterCollection);
                return true;
            }
            catch
            { return false; }
        }

        
    }
}
