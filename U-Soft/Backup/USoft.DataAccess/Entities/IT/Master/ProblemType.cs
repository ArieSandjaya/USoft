using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.IT.Master
{
    public class ProblemType : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ProblemTypeCode;
        private string _ProblemTypeName;

        // Method
        public string ProblemTypeCode
        {
            get { return _ProblemTypeCode; }
            set { _ProblemTypeCode = value; }
        }

        public string ProblemTypeName
        {
            get { return _ProblemTypeName; }
            set { _ProblemTypeName = value; }
        }
    }
}
