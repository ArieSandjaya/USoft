using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Currency : USoft.DataAccess.Entities.General
    {
        // Member
        private string _CurrencyCode;
        private string _CurrencyName;
        
        // Method
        public string CurrencyCode
        {
            get { return _CurrencyCode; }
            set { _CurrencyCode = value; }
        }

        public string CurrencyName
        {
            get { return _CurrencyName; }
            set { _CurrencyName = value; }
        }
    }
}
