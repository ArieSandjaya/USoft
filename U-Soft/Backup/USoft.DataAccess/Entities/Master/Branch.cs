using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Branch : USoft.DataAccess.Entities.General
    {
        // Member
        private string _BranchCode;
        private int _BranchType;
        private int _BranchParent;

        // Method

        public string BranchCode
        {
            get { return _BranchCode; }
            set { _BranchCode = value; }
        }

        public int BranchType
        {
            get { return _BranchType; }
            set { _BranchType = value; }
        }

        public int BranchParent
        {
            get { return _BranchParent; }
            set { _BranchParent = value; }
        }
    }
}
