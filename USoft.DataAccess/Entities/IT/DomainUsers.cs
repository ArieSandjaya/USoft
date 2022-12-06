using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.IT
{
    public class DomainUsers : USoft.DataAccess.Entities.General
    {
        // Variable
        private string _BranchCodeOld;
        private string _BranchCode;
        private string _BranchIP;
        private string _UserName;
        private string _Password;

        // Method
        public string BranchCodeOld
        {
            get { return _BranchCodeOld; }
            set { _BranchCodeOld = value; }
        }

        public string BranchCode
        {
            get { return _BranchCode; }
            set { _BranchCode = value; }
        }

        public string BranchIP
        {
            get { return _BranchIP; }
            set { _BranchIP = value; }
        }

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        public string Password
        {
            get { return _Password; }
            set { _Password = value; }
        }
    }
}
