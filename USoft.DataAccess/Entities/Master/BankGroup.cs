using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class BankGroup : USoft.DataAccess.Entities.General
    {
        // Member
        private string _BankGroupCode;
        private string _BankGroupName;

        // Method
        public string BankGroupCode
        {
            get { return _BankGroupCode; }
            set { _BankGroupCode = value; }
        }

        public string BankGroupName
        {
            get { return _BankGroupName; }
            set { _BankGroupName = value; }
        }
    }
}
