using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;

namespace USoft.Globalization.Classes
{
    public class GridFilter
    {
        public GridFilter()
        {}
        public string BuildQuery(System.Collections.Specialized.NameValueCollection query)
        {
            string queryString = "";
            string[] values = query.GetValues("filterscount");
            if (values != null && values.Length > 0)
            {
                int filtersCount = int.Parse(query.GetValues("filterscount")[0]);
                string where = "";
                if (filtersCount > 0)
                {
                    where += " AND (" + BuildFilters(filtersCount, query);
                }
                queryString += where;
            }
            return queryString;
        }
        private string BuildFilters(int filtersCount, System.Collections.Specialized.NameValueCollection query)
        {
            string tmpDataField = "";
            string where = "";
            string tmpFilterOperator = "";
            for (int i = 0; i < filtersCount; i += 1)
            {
                string filterValue = query.GetValues("filtervalue" + i)[0];
                string filterCondition = query.GetValues("filtercondition" + i)[0];
                string filterDataField = query.GetValues("filterdatafield" + i)[0];
                string filterOperator = query.GetValues("filteroperator" + i)[0];
                if (tmpDataField == "")
                {
                    tmpDataField = filterDataField;
                }
                else if (tmpDataField != filterDataField)
                {
                    where += ") AND (";
                }
                else if (tmpDataField == filterDataField)
                {
                    if (tmpFilterOperator == "")
                    {
                        where += " AND ";
                    }
                    else
                    {
                        where += " OR ";
                    }
                }
                // build the "WHERE" clause depending on the filter's condition, value and datafield.
                where += GetFilterCondition(filterCondition, filterDataField, filterValue);
                if (i == filtersCount - 1)
                {
                    where += ")";
                }
                tmpFilterOperator = filterOperator;
                tmpDataField = filterDataField;
            }
            return where;
        }
        private string GetFilterCondition(string filterCondition, string filterDataField, string filterValue)
        {
            switch (filterCondition)
            {
                case "NOT_EMPTY":
                case "NOT_NULL":
                    return " " + filterDataField + " NOT LIKE '" + "" + "'";
                case "EMPTY":
                case "NULL":
                    return " " + filterDataField + " LIKE '" + "" + "'";
                case "CONTAINS_CASE_SENSITIVE":
                    return " " + filterDataField + " LIKE '%" + filterValue + "%'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";
                case "CONTAINS":
                    return " " + filterDataField + " LIKE '%" + filterValue + "%'";
                case "DOES_NOT_CONTAIN_CASE_SENSITIVE":
                    return " " +filterDataField + " NOT LIKE '%" + filterValue + "%'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "DOES_NOT_CONTAIN":
                    return " " + filterDataField + " NOT LIKE '%" + filterValue + "%'";
                case "EQUAL_CASE_SENSITIVE":
                    return " " + filterDataField + " = '" + filterValue + "'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "EQUAL":
                    return " " + filterDataField + " = '" + filterValue + "'";
                case "NOT_EQUAL_CASE_SENSITIVE":
                    return " BINARY " + filterDataField + " <> '" + filterValue + "'";
                case "NOT_EQUAL":
                    return " " + filterDataField + " <> '" + filterValue + "'";
                case "GREATER_THAN":
                    return " " + filterDataField + " > '" + filterValue + "'";
                case "LESS_THAN":
                    return " " + filterDataField + " < '" + filterValue + "'";
                case "GREATER_THAN_OR_EQUAL":
                    return " " + filterDataField + " >= '" + filterValue + "'";
                case "LESS_THAN_OR_EQUAL":
                    return " " + filterDataField + " <= '" + filterValue + "'";
                case "STARTS_WITH_CASE_SENSITIVE":
                    return " " + filterDataField + " LIKE '" + filterValue + "%'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "STARTS_WITH":
                    return " " + filterDataField + " LIKE '" + filterValue + "%'";
                case "ENDS_WITH_CASE_SENSITIVE":
                    return " " + filterDataField + " LIKE '%" + filterValue + "'" + " COLLATE SQL_Latin1_General_CP1_CS_AS";;
                case "ENDS_WITH":
                    return " " + filterDataField + " LIKE '%" + filterValue + "'";
            }
            return "";
        }
        public int getTotalRow(string ProcedureName,List<KeyValuePair<string, object>> ParameterCollection)
        {
            int iTotal=0;
            SQLHandler sqlHandler = new SQLHandler();
            SqlDataReader dr = sqlHandler.ExecuteAsDataReader(ProcedureName,ParameterCollection);
               while(dr.Read())
               {
                   iTotal = Convert.ToInt16(dr[0]);
               }
            return iTotal;
        }
    }
}
