using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Privilege : USoft.DataAccess.Entities.General
    {
        // Member
        private string _PrivilegeCode;
        private string _PrivilegeName;
        private string _OldCode;
        private string _UserId;

        private int _MenuId; 
        private bool _Insert;
        private bool _Update;
        private bool _Delete;
        private bool _View;

        // Method
        public string PrivilegeCode
        {
            get { return _PrivilegeCode; }
            set { _PrivilegeCode = value; }
        }

        public string PrivilegeName
        {
            get { return _PrivilegeName; }
            set { _PrivilegeName = value; }
        }

        public string OldCode
        {
            get { return _OldCode; }
            set { _OldCode = value; }
        }

        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public int MenuId
        {
            get { return _MenuId; }
            set { _MenuId = value; }
        }

        public bool Insert
        {
            get { return _Insert; }
            set { _Insert = value; }
        }

        public bool Update
        {
            get { return _Update; }
            set { _Update = value; }
        }

        public bool Delete
        {
            get { return _Delete; }
            set { _Delete = value; }
        }

        public bool View
        {
            get { return _View; }
            set { _View = value; }
        }
    }
}
