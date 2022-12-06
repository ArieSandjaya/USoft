using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Users : USoft.DataAccess.Entities.General
    {
        // Member
        private string _UserId;
        private string _Pass;
        private string _UserName;
        private string _Email;
        private string _UgetsValue;
        private string _GroupId;
        private string _PrivilegeCode;
        private string _CanSendEmail;
        private string _CanChangePass;
        private bool _IsAllBranch;

        private int _MenuId;
        private bool _Insert;
        private bool _Update;
        private bool _Delete;
        private bool _View;
        
        // Method
        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public string Pass
        {
            get { return _Pass; }
            set { _Pass = value; }
        }

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }

        public string UgetsValue
        {
            get { return _UgetsValue; }
            set { _UgetsValue = value; }
        }

        public string GroupId
        {
            get { return _GroupId; }
            set { _GroupId = value; }
        }

        public string PrivilegeCode
        {
            get { return _PrivilegeCode; }
            set { _PrivilegeCode = value; }
        }

        public string CanSendEmail
        {
            get { return _CanSendEmail; }
            set { _CanSendEmail = value; }
        }

        public string CanChangePass
        {
            get { return _CanChangePass; }
            set { _CanChangePass = value; }
        }

        public bool IsAllBranch
        {
            get { return _IsAllBranch; }
            set { _IsAllBranch = value; }
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
