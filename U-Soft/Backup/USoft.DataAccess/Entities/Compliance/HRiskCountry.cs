using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Compliance
{
    public class HRiskCountry: USoft.DataAccess.Entities.General
    {
        #region Member
            private string _countryName;
        #endregion
        #region Method
            public string CountryName
                {
                    get { return _countryName; }
                    set { _countryName = value; }
                }
        #endregion

        }
}
