using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities
{
    public class General
    {
        // Member
        private string _where_by;
        private string _where_is;
        private string _input_by;
        private string _created_by;
        private string _created_name;
        private string _update_by;
        private string _update_name;
        private int _branch_id;
        private string _branch_name;
        private string _departement_code;
        private string _departement_name;
        private string _description;
        private string _query;

        private bool _IsActive;
        private int _ApprovalState;
        private int _PageNo;
	    private int _PageSize;
	    private int _TotalPage;
        private int _TotalData;

        private object _objectCollection;

        // Method
        public string WhereIs
        {
            get { return _where_is; }
            set { _where_is = value; }
        }

        public string WhereBy
        {
            get { return _where_by; }
            set { _where_by = value; }
        }

        public string MyQuery
        {
            get { return _query; }
            set { _query = value; }
        }

        public string InputBy
        {
            get { return _input_by; }
            set { _input_by = value; }
        }

        public string CreatedBy
        {
            get { return _created_by; }
            set { _created_by = value; }
        }

        public string CreatedName
        {
            get { return _created_name; }
            set { _created_name = value; }
        }

        public string UpdateBy
        {
            get { return _update_by; }
            set { _update_by = value; }
        }

        public string UpdateName
        {
            get { return _update_name; }
            set { _update_name = value; }
        }

        public int BranchId
        {
            get { return _branch_id; }
            set { _branch_id = value; }
        }

        public string BranchName
        {
            get { return _branch_name; }
            set { _branch_name = value; }
        }

        public string DepartementCode
        {
            get { return _departement_code; }
            set { _departement_code = value; }
        }

        public string DepartementName
        {
            get { return _departement_name; }
            set { _departement_name = value; }
        }

        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public bool IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }

        public int ApprovalState
        {
            get { return _ApprovalState; }
            set { _ApprovalState = value; }
        }

        public int PageNo
        {
            get { return _PageNo; }
            set { _PageNo = value; }
        }

        public int PageSize
        {
            get { return _PageSize; }
            set { _PageSize = value; }
        }

        public int TotalPage
        {
            get { return _TotalPage; }
            set { _TotalPage = value; }
        }

        public int TotalData
        {
            get { return _TotalData; }
            set { _TotalData = value; }
        }

        public object ObjectCollection
        {
            get { return _objectCollection; }
            set { _objectCollection = value; }
        }
    }
}
