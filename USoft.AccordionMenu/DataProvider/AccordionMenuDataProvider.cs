using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web;
using System.Web.Caching;
using USoft.Common.Shared;
using System.Web.UI.WebControls;


namespace USoft.AccordionMenu.DataProvider
{
    public class AccordionMenuDataProvider
    {
        public List<object> AccordionInfo(string UserName)
        {
            DataSet ds = new DataSet();
            DataSet dsMenu = new DataSet();
            List<object> lst = new List<object>();
            
            HttpRuntime.Cache.Remove("MenuCache");
            //if (HttpRuntime.Cache["MenuCache"] == null)
            //{
            AccordionMenuData.GetAllMenu(UserName);
            //}
            
            ds = (DataSet)HttpRuntime.Cache["MenuCache"];
            dsMenu = ds.Clone();
            //dr = ds.Tables[0].Rows; //.Select("UserId = '" + UserName + "'", "UserId,MenuId");
            foreach (DataRow rows in ds.Tables[0].Rows)
            {
                dsMenu.Tables[0].ImportRow(rows);
            }
            dsMenu.Relations.Add(new DataRelation("dataRelations", dsMenu.Tables[0].Columns["MenuId"], dsMenu.Tables[0].Columns["MenuParent"]));
            string trValue = "";
            foreach (DataRow sqlRow in dsMenu.Tables[0].Rows)
            {
                if (sqlRow["MenuId"].ToString() == sqlRow["MenuParent"].ToString())
                {
                    TreeNode trNode = new TreeNode();
                    trNode.Text = sqlRow["MenuName"].ToString();
                    trValue = "?validate=" + sqlRow["MenuId"];//  + sqlRow["UserId"] +"~" insert=" + sqlRow["InsertDt"].ToString() + "&update=" + sqlRow["UpdateDt"].ToString() + "&delete=" + sqlRow["DeleteDt"].ToString() + "&view=" + sqlRow["ViewDt"].ToString()+sqlRow["Parameter"].ToString();
                    if (sqlRow["Parameter"] != System.DBNull.Value)
                    {
                        trValue += "~" + sqlRow["Parameter"].ToString();
                    }
                    if (sqlRow["MenuLink"].ToString() != "")
                    {
                        trNode.NavigateUrl = "javascript:void;ChangeIFrameLocation('" + sqlRow["MenuLink"].ToString() + trValue + "');";
                    }
                    else
                    {
                        trNode.NavigateUrl = "javascript:void(0)";
                    }
                    lst.Add(trNode);
                    GetMenuClient(sqlRow, trNode);
                }
            }
            return lst;
        }
        private static void GetMenuClient(DataRow dr, TreeNode trChild)
        {
            foreach (DataRow rows in dr.GetChildRows("dataRelations"))
            {
                if (rows["MenuParent"].ToString() != rows["MenuId"].ToString())
                {
                    TreeNode trChild2 = new TreeNode();
                    string trValue = "";
                    trChild2.Text = rows["MenuName"].ToString();
                    trValue = "?validate=" + rows["MenuId"]; //+ rows["UserId"] + "~"
                    if (rows["Parameter"] != System.DBNull.Value)
                    {
                        trValue += "~" + rows["Parameter"].ToString();
                    }
                    if (rows["MenuLink"].ToString() != "")
                    {
                        if (rows["ReportId"].ToString() == "")
                        {
                            trChild2.NavigateUrl = "javascript:ChangeIFrameLocation('" + rows["MenuLink"].ToString() + trValue + "');";
                        }
                        else
                        {
                            trChild2.NavigateUrl = "javascript:ChangeIFrameLocation('" + rows["MenuLink"].ToString() + "?ReportId=" + rows["ReportId"].ToString() + "&Params=" + rows["Parameter"].ToString() + "');";
                        }
                    }
                    else
                    {
                        trChild2.NavigateUrl = "javascript:void(0)";
                    }
                    trChild.ChildNodes.Add(trChild2);
                    GetMenuClient(rows, trChild2);
                }
            }
        }
    }
}
