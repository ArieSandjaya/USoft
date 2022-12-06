using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.IT.Master
{
    public class ItemType : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ItemTypeCode;
        private string _ItemTypeName;

        // Method
        public string ItemTypeCode
        {
            get { return _ItemTypeCode; }
            set { _ItemTypeCode = value; }
        }

        public string ItemTypeName
        {
            get { return _ItemTypeName; }
            set { _ItemTypeName = value; }
        }
    }
}
