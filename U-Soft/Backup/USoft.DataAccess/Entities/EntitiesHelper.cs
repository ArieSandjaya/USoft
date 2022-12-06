using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities
{
    public class EntitiesHelper
    {
        public EntitiesHelper()
        {}
        public static string[] GetWhereIs(string value)
        {
            return value.Split(new char[1]{'~'});
        }
    }
}
