using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities
{
    public class UserInfo
    {
        private string _UserId;
        private int _BranchId;
        private int _DataBranchId;
        private string _PrivilegeCode;
        private string _DepartementCode;
        private bool _IsAllBranch;
        private bool _IsActive;
        private int _MenuId;
        private int _State;
        private int _MaxState;
        private bool _ApprovalState;

        // Method
        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public int BranchId
        {
            get { return _BranchId; }
            set { _BranchId = value; }
        }

        public int DataBranchId
        {
            get { return _DataBranchId; }
            set { _DataBranchId = value; }
        }

        public string PrivilegeCode
        {
            get { return _PrivilegeCode; }
            set { _PrivilegeCode = value; }
        }

        public string DepartementCode
        {
            get { return _DepartementCode; }
            set { _DepartementCode = value; }
        }

        public bool IsAllBranch
        {
            get { return _IsAllBranch; }
            set { _IsAllBranch = value; }
        }

        public bool IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }

        public int MenuId
        {
            get { return _MenuId; }
            set { _MenuId = value; }
        }

        public int State
        {
            get { return _State; }
            set { _State = value; }
        }

        public int MaxState
        {
            get { return _MaxState; }
            set { _MaxState = value; }
        }

        public bool ApprovalState
        {
            get { return _ApprovalState; }
            set { _ApprovalState = value; }
        }
    }
}
