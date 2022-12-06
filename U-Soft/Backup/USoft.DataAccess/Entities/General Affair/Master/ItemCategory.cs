using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.General_Affair.Master
{
    public class ItemCategory : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ItemCategoryCode;
        private string _ItemCategoryName;

        // Method
        public string ItemCategoryCode
        {
            get { return _ItemCategoryCode; }
            set { _ItemCategoryCode = value; }
        }

        public string ItemCategoryName
        {
            get { return _ItemCategoryName; }
            set { _ItemCategoryName = value; }
        }
    }
}
