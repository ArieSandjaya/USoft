using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.General_Affair.Master
{
    public class ItemGroup : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ItemGroupCode;
        private string _ItemGroupName;
        private string _ItemCategoryCode;
        
        // Method
        public string ItemGroupCode
        {
            get { return _ItemGroupCode; }
            set { _ItemGroupCode = value; }
        }

        public string ItemGroupName
        {
            get { return _ItemGroupName; }
            set { _ItemGroupName = value; }
        }

        public string ItemCategoryCode
        {
            get { return _ItemCategoryCode; }
            set { _ItemCategoryCode = value; }
        }
    }
}
