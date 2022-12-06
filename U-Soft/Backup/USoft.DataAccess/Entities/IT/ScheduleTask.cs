using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.IT
{
    public class ScheduleTask : USoft.DataAccess.Entities.General
    {
        // Member
        private string _ScheduleNo;
        private string _ScheduleType;
        private string _ScheduleTitle;
        private DateTime _StartDate;
        private DateTime _EndDate;
        private string _IntervalBy;
        private int _IntervalRange;
        private string _IntervalHour;
        private string _IntervalMinute;
        private string _Status;
        private string _UserCreated;
        private DateTime _CreatedDate;
        private DateTime _UpdateDate;

        // Method
        public string ScheduleNo
        {
            get { return _ScheduleNo; }
            set { _ScheduleNo = value; }
        }

        public string ScheduleType
        {
            get { return _ScheduleType; }
            set { _ScheduleType = value; }
        }

        public string ScheduleTitle
        {
            get { return _ScheduleTitle; }
            set { _ScheduleTitle = value; }
        }

        public DateTime StartDate
        {
            get { return _StartDate; }
            set { _StartDate = value; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public string IntervalBy
        {
            get { return _IntervalBy; }
            set { _IntervalBy = value; }
        }

        public int IntervalRange
        {
            get { return _IntervalRange; }
            set { _IntervalRange = value; }
        }

        public string IntervalHour
        {
            get { return _IntervalHour; }
            set { _IntervalHour = value; }
        }

        public string IntervalMinute
        {
            get { return _IntervalMinute; }
            set { _IntervalMinute = value; }
        }

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        public string UserCreated
        {
            get { return _UserCreated; }
            set { _UserCreated = value; }
        }

        public DateTime CreatedDate
        {
            get { return _CreatedDate; }
            set { _CreatedDate = value; }
        }

        public DateTime UpdateDate
        {
            get { return _UpdateDate; }
            set { _UpdateDate = value; }
        }
    }
}
