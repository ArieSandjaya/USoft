using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.DirectoryServices;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.DataAccess.IT
{
    public class DomainUsers
    {
        // Parameter
        string pivchBranchCodeOld = "@pivchBranchCodeOld";
        string pivchBranchCode = "@pivchBranchCode";
        string pivchBranchName = "@pivchBranchName";
        string pivchBranchIP = "@pivchBranchIP";
        string pivchUserName = "@pivchUserName";
        string pivchPassword = "@pivchPassword";
        string pivchInputID = "@pivchInputID"; 

        // Store Procedure
        string spBranchDomainInsert = "spBranchDomainInsert";
        string spBranchDomainUpdate = "spBranchDomainUpdate";
        string spBranchDomainView = "spBranchDomainView";
        
        // Field Name
        string BranchCode = "Branch_Code";
        string BranchName = "Branch_Name";
        string BranchIP = "Branch_IP";
        string UserName = "UserName";
        string Password = "Password";

        string No = "No";
        string Name = "Name";
        string Organization = "Organization";
        string Branch = "Branch";

        public void getBranchDomainView(ref USoft.DataAccess.Entities.IT.DomainUsers info)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchCode, info.BranchCode));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spBranchDomainView, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        info.BranchCode = dr[BranchCode].ToString();
                        info.BranchName = dr[BranchName].ToString();
                        info.BranchIP = dr[BranchIP].ToString();
                        info.UserName = dr[UserName].ToString();
                        info.Password = dr[Password].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public String BranchDomainInsert(USoft.DataAccess.Entities.IT.DomainUsers info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchCode, info.BranchCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchName, info.BranchName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchIP, info.BranchIP));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserName, info.UserName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPassword, info.Password));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spBranchDomainInsert, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }

        public String BranchDomainUpdate(USoft.DataAccess.Entities.IT.DomainUsers info)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String sqlMsg;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchCodeOld, info.BranchCodeOld));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchCode, info.BranchCode));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchName, info.BranchName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchBranchIP, info.BranchIP));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserName, info.UserName));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchPassword, info.Password));
            ParameterCollection.Add(new KeyValuePair<string, object>(pivchInputID, info.InputBy));

            try
            {
                sqlHandler.ExecuteAsDataSet(spBranchDomainUpdate, ParameterCollection);
                sqlMsg = "Process Success";
            }
            catch (Exception ex)
            {
                sqlMsg = "Process Failed : " + ex.Message;
            }
            return sqlMsg;
        }
        
        public DataTable getDomainUsers(USoft.DataAccess.Entities.IT.DomainUsers info)
        {
            int i = 0;
            DirectorySearcher ds = new DirectorySearcher();
            DataTable table = new DataTable();
            DataColumn column;
            DataRow row;

            column = new DataColumn();
            column.ColumnName = No;
            table.Columns.Add(column);
            column = new DataColumn();
            column.ColumnName = Name;
            table.Columns.Add(column);
            column = new DataColumn();
            column.ColumnName = Organization;
            table.Columns.Add(column);
            column = new DataColumn();
            column.ColumnName = UserName;
            table.Columns.Add(column);
            column = new DataColumn();
            column.ColumnName = Branch;
            table.Columns.Add(column);

            try
            {
                getBranchDomainView(ref info);

                ds.SearchRoot = new DirectoryEntry("LDAP://" + info.BranchIP, info.UserName, info.Password);
                ds.Filter = "(&(&(objectClass=user)(userAccountControl=512)))";
                ds.PropertyNamesOnly = true;
                ds.Sort = new SortOption("name", System.DirectoryServices.SortDirection.Ascending);
                foreach (SearchResult sr in ds.FindAll())
                {
                    i += 1;
                    DirectoryEntry de = sr.GetDirectoryEntry();
                    row = table.NewRow();
                    row["No"] = i.ToString();
                    row["Name"] = de.Name.Substring(3);
                    row["Organization"] = de.Parent.Name.Substring(3);
                    row["UserName"] = (string)de.Properties["samaccountname"].Value ?? " <Undefined>";
                    row["Branch"] = Branch;
                    table.Rows.Add(row);
                }
                return table;
            }
            catch
            {
                throw;
            }
        }
    }
}
