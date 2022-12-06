using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.ComponentModel;
using USoft.Common.Shared;

namespace USoft.Modules.Marketing.CashReward
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService()] // To allow this Web Service to be called from script, using ASP.NET AJAX
    public class UpdateCachReward : System.Web.Services.WebService
    {
        [WebMethod]
        public void UpdateSelection(string Period, string Contract, string SupplierType, string RefundRecipient, string SupplierCd, string BrandCd, string RecipientName, string ckPaid, string ckLater)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", Period));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CONTRACT_ID", Contract));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SUPPLIER_TYPE", SupplierType));
            ParameterCollection.Add(new KeyValuePair<string, object>("@REFUND_RECIPIENT_ID", RefundRecipient));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SUPPLIER_CODE", SupplierCd));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRAND_CODE", BrandCd));
            ParameterCollection.Add(new KeyValuePair<string, object>("@RECIPIENT_NAME", RecipientName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PAID_IN_SAME_PERIOD", ckPaid));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PAID_NOT_IN_SAME_PERIOD", ckLater));
            ParameterCollection.Add(new KeyValuePair<string, object>("@AMOUNT", 0));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 0));
            sqlHandler.ExecuteNonQuery("CASH_REWARD_UPDATE", ParameterCollection);            
        }
        [WebMethod]
        public void UpdateAmount(string Period, string Contract, string SupplierType, string RefundRecipient, string SupplierCd, string BrandCd, string RecipientName, string Amount)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@PERIOD", Period));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CONTRACT_ID", Contract));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SUPPLIER_TYPE", SupplierType));
            ParameterCollection.Add(new KeyValuePair<string, object>("@REFUND_RECIPIENT_ID", RefundRecipient));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SUPPLIER_CODE", SupplierCd));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BRAND_CODE", BrandCd));
            ParameterCollection.Add(new KeyValuePair<string, object>("@RECIPIENT_NAME", RecipientName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PAID_IN_SAME_PERIOD", 'N'));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PAID_NOT_IN_SAME_PERIOD", 'N'));
            ParameterCollection.Add(new KeyValuePair<string, object>("@AMOUNT", Amount));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Type", 1));
            sqlHandler.ExecuteNonQuery("CASH_REWARD_UPDATE", ParameterCollection);            
        }

    }
}
