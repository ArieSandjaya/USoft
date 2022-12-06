using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;
using System.Data.SqlClient;

namespace USoft.Compliance.Master
{
    public class DealerSearch
    {
        private string _namadealer;
        private string _status;
        private string _kodeDealer;
        public DealerSearch()
        { }

        public DataTable GetDealer()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@NamaDealer", _namadealer));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Status", _status));
            ParameterCollection.Add(new KeyValuePair<string, object>("@KodeDealer", _kodeDealer));
            return sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_SEARCH_DEALER", ParameterCollection);
        }

        public string NamaDealer
        {
            set { _namadealer = value; }
        }
        public string Status
        {
            set { _status = value = value == "null" ? null : value; ; }
        }
        public string KodeDealer
        {
            set { _kodeDealer = value = value == "null" ? null : value; ; }
        }
    }
}
