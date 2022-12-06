using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.IT
{
    public class ActivityTask : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ActivityNo;
        private DateTime _ActivityDate;
        private string _RequestBy;
        //private string _Email;
        private int _ProblemTypeCode;
        private string _ProblemTypeName;
		private string _ItemTypeCode;
        private string _ItemTypeName;
        private string _Status;
        private string _Priority;
        private string _PIC;
        private string _TerminatedBy;
        private string _AssignTo;
        private string _AssignFrom;
        private string _AssignDescription;
        private string _AssignStatus;

        // Method
        public string ActivityNo
        {
            get { return _ActivityNo; }
            set { _ActivityNo = value; }
        }

        public DateTime ActivityDate
        {
            get { return _ActivityDate; }
            set { _ActivityDate = value; }
        }

        public string RequestBy
        {
            get { return _RequestBy; }
            set { _RequestBy = value; }
        }

        //public string Email
        //{
        //    get { return _Email; }
        //    set { _Email = value; }
        //}

        public int ProblemTypeCode
        {
            get { return _ProblemTypeCode; }
            set { _ProblemTypeCode = value; }
        }

        public string ProblemTypeName
        {
            get { return _ProblemTypeName; }
            set { _ProblemTypeName = value; }
        }

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

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        public string Priority
        {
            get { return _Priority; }
            set { _Priority = value; }
        }

        public string PIC
        {
            get { return _PIC; }
            set { _PIC = value; }
        }

        public string TerminatedBy
        {
            get { return _TerminatedBy; }
            set { _TerminatedBy = value; }
        }

        public string AssignTo
        {
            get { return _AssignTo; }
            set { _AssignTo = value; }
        }

        public string AssignFrom
        {
            get { return _AssignFrom; }
            set { _AssignFrom = value; }
        }

        public string AssignDescription
        {
            get { return _AssignDescription; }
            set { _AssignDescription = value; }
        }

        public string AssignStatus
        {
            get { return _AssignStatus; }
            set { _AssignStatus = value; }
        }
    }
}