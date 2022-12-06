using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.General_Affair.Master
{
    public class ItemType : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ItemTypeCode;
        private string _ItemTypeName;
        private string _ItemGroupCode;
        private string _ItemCategoryCode;
        private string _MeasurementCode;

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

        public string ItemGroupCode
        {
            get { return _ItemGroupCode; }
            set { _ItemGroupCode = value; }
        }

        public string ItemCategoryCode
        {
            get { return _ItemCategoryCode; }
            set { _ItemCategoryCode = value; }
        }

        public string MeasurementCode
        {
            get { return _MeasurementCode; }
            set { _MeasurementCode = value; }
        }
    }
}
