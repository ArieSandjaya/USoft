using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Supplier : USoft.DataAccess.Entities.General
    {
        // Member
        private string _SupplierCode;
        private string _SupplierName;
        private string _Address;
        private string _City;
        private string _ZipCode;
        private string _Phone;
        private string _NPWP;
        private string _State;
        
        // Method
        public string SupplierCode
        {
            get { return _SupplierCode; }
            set { _SupplierCode = value; }
        }

        public string SupplierName
        {
            get { return _SupplierName; }
            set { _SupplierName = value; }
        }

        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }

        public string City
        {
            get { return _City; }
            set { _City = value; }
        }

        public string ZipCode
        {
            get { return _ZipCode; }
            set { _ZipCode = value; }
        }

        public string Phone
        {
            get { return _Phone; }
            set { _Phone = value; }
        }

        public string NPWP
        {
            get { return _NPWP; }
            set { _NPWP = value; }
        }

        public string State
        {
            get { return _State; }
            set { _State = value; }
        }
    }
}
