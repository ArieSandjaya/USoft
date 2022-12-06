using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Condition : USoft.DataAccess.Entities.General
    {
        // Member
        private int _ConditionCode;
        private string _ConditionName;
        
        // Method
        public int ConditionCode
        {
            get { return _ConditionCode; }
            set { _ConditionCode = value; }
        }

        public string ConditionName
        {
            get { return _ConditionName; }
            set { _ConditionName = value; }
        }
    }
}
