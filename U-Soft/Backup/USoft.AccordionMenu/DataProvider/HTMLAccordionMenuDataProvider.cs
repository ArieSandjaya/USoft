using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web.Caching;
using USoft.Common.Shared;
using System.Web.UI.WebControls;

namespace USoft.AccordionMenu.DataProvider
{
    public class HTMLAccordionMenuDataProvider
    {
        static StringBuilder sBuilder = new StringBuilder();
        public StringBuilder AccordionInfo(string UserName, string Privilege)
        {
            List<object> lst = new List<object>();
            Cache myCache = new Cache();
            DataSet ds = new DataSet();
            SQLHandler Handler = new SQLHandler();
            ds = Handler.ExecuteAsDataSet("spGetMenuUsers");

            DataSet dsMenu = new DataSet();
            DataRow[] dr;
            dsMenu = ds.Clone();

            dr = ds.Tables[0].Select("PriveledgeCode = '" + Privilege + "'", "PriveledgeCode,MenuId");
            foreach (DataRow rows in dr)
            {
                dsMenu.Tables[0].ImportRow(rows);
            }
            dsMenu.Relations.Add(new DataRelation("dataRelations", dsMenu.Tables[0].Columns["MenuId"], dsMenu.Tables[0].Columns["MenuParent"]));

            foreach (DataRow sqlRow in dsMenu.Tables[0].Rows)
            {
                if (sqlRow["MenuId"].ToString() == sqlRow["MenuParent"].ToString())
                {
                    TreeNode trNode = new TreeNode();
                    sBuilder.Append("<h3>" + sqlRow["MenuName"].ToString() + "</h3>");
                    sBuilder.Append("<div style='width: 100%;'>");
                    GetMenuClient(sqlRow, trNode);
                    sBuilder.Append("</div>");
                }
            }
            //return treeview;
            return sBuilder;
        }
        private static void GetMenuClient(DataRow dr, TreeNode trChild)
        {
            sBuilder.Append("<ul>");
            foreach (DataRow rows in dr.GetChildRows("dataRelations"))
            {
                if (rows["MenuParent"].ToString() != rows["MenuId"].ToString())
                {
                    sBuilder.Append("<li><a href=" + "\"" + "javascript:ChangeIFrameLocation(\'"+ rows["MenuLink"].ToString()+ "\')\";><span>" + rows["MenuName"].ToString() + "</span></a></li>");
                    TreeNode trChild2 = new TreeNode();
                    trChild.ChildNodes.Add(trChild2);
                    GetMenuClient(rows, trChild2);
                }
            }
            sBuilder.Append("</ul>");
        }
    }
}
