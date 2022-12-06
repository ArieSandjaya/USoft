using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Master
{
    public class Measurement : USoft.DataAccess.Entities.General
    {
        // Member
        private string _MeasurementCode;
        private string _MeasurementName;

        // Method
        public string MeasurementCode
        {
            get { return _MeasurementCode; }
            set { _MeasurementCode = value; }
        }

        public string MeasurementName
        {
            get { return _MeasurementName; }
            set { _MeasurementName = value; }
        }
    }
}
