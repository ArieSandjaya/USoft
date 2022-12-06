using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class MappingApproval : USoft.DataAccess.Entities.General
    {
        // Member
        private int _ApprovalId;
        private int _MenuId;
        private string _MenuName;
        private string _ParentCode;
        private string _ParentName;
        private string _UserIdApproval;
        private bool _IsBranch;
        private int _State;
        private string _StateDescription;
        private int _ApprovalEmailId;
        private string _UserIdEmail;
        private string _UserEmail;

        // Method
        public int ApprovalId
        {
            get { return _ApprovalId; }
            set { _ApprovalId = value; }
        }

        public int MenuId
        {
            get { return _MenuId; }
            set { _MenuId = value; }
        }

        public string MenuName
        {
            get { return _MenuName; }
            set { _MenuName = value; }
        }

        public string ParentCode
        {
            get { return _ParentCode; }
            set { _ParentCode = value; }
        }

        public string ParentName
        {
            get { return _ParentName; }
            set { _ParentName = value; }
        }

        public string UserIdApproval
        {
            get { return _UserIdApproval; }
            set { _UserIdApproval = value; }
        }

        public bool IsBranch
        {
            get { return _IsBranch; }
            set { _IsBranch = value; }
        }

        public int State
        {
            get { return _State; }
            set { _State = value; }
        }

        public string StateDescription
        {
            get { return _StateDescription; }
            set { _StateDescription = value; }
        }

        public int ApprovalEmailId
        {
            get { return _ApprovalEmailId; }
            set { _ApprovalEmailId = value; }
        }

        public string UserIdEmail
        {
            get { return _UserIdEmail; }
            set { _UserIdEmail = value; }
        }

        public string UserEmail
        {
            get { return _UserEmail; }
            set { _UserEmail = value; }
        }
    }
}
