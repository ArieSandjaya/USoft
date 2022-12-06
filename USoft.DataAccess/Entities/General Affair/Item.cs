using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.General_Affair
{
    public class Item : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ItemCode;
        private string _ItemTypeCode;
        private double _Quantity;
        private double _RequestQty;

        // Method
        public string ItemCode
        {
            get { return _ItemCode; }
            set { _ItemCode = value; }
        }

        public string ItemTypeCode
        {
            get { return _ItemTypeCode; }
            set { _ItemTypeCode = value; }
        }

        public double Quantity
        {
            get { return _Quantity; }
            set { _Quantity = value; }
        }

        public double RequestQty
        {
            get { return _RequestQty; }
            set { _RequestQty = value; }
        }
    }
}
