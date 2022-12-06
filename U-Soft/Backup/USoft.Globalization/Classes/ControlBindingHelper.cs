using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;
using USoft.Common.Shared;
using System.Web;
using System.Data;

namespace USoft.Globalization.Classes
{
    public class ControlBindingHelper
    {
        public ControlBindingHelper()
        { }
        public static void BindMyDropDownListAsBranch(DropDownList myControl, bool IsUsePleaseSelect)
        {
            SetBinding(myControl, "lookup_branch", "BranchName", "BranchId");
            if (IsUsePleaseSelect == true)
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "Please Select";
                myControl.Items.Insert(0, l);
            }
        }
        public static void BindMyDropDownListAsBrand(DropDownList myControl, bool IsUsePleaseSelect)
        {
            SetBinding(myControl, "lookup_brand", "brand_name", "brand_name");
            if (IsUsePleaseSelect == true)
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "Please Select";
                myControl.Items.Insert(0, l);
            }
            else
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "";
                myControl.Items.Insert(0, l);
            }
        }
        public static void BindMyDropDownListAsEntCompany(DropDownList myControl, bool IsUsePleaseSelect,bool IsNotInTheList)
        {
            SetBinding(myControl, "lookup_ent_dealer","NamaDealer", "KodeDealer");
            if (IsUsePleaseSelect == true)
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "Please Select";
                myControl.Items.Insert(0, l);
            }
            else
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "";
                myControl.Items.Insert(0, l);
            }
            if (IsNotInTheList == true)
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "Not In The Lists...";
                myControl.Items.Add(l);
            }
        }
        public static void BindMyDropDownListAsEntDept(DropDownList myControl, bool IsUsePleaseSelect)
        {
            SetBinding(myControl, "lookup_ent_dept", "DeptName", "DeptCode");
            if (IsUsePleaseSelect == true)
            {
                ListItem l = new ListItem();
                l.Value = "";
                l.Text = "Please Select";
                myControl.Items.Insert(0, l);
            }
        }
        public static void BindTable(GridView myGrid,DataTable dt)
        {
            myGrid.DataSource = dt;
            myGrid.DataBind();
        }
        private static void SetBinding(DropDownList myControl,string Category,string TextField,string ValueField)
        {
            string strCache = "";
            switch (Category)
            {
                case "lookup_branch":
                    if (HttpContext.Current.Cache["BRANCH"] == null)
                    {
                        AppStart.GetBranch();
                    }
                    strCache = "BRANCH";
                    break;
                case "lookup_ent_dealer":
                    if (HttpContext.Current.Cache["ENTDEALER"] == null)
                    {
                        AppStart.GetEntCompanyName();
                    }
                    strCache = "ENTDEALER";
                    break;
                case "lookup_ent_dept":
                    if (HttpContext.Current.Cache["ENTDEPT"] == null)
                    {
                        AppStart.GetEntDept();
                    }
                    strCache = "ENTDEPT";
                    break;
                case "lookup_brand":
                    if (HttpContext.Current.Cache["BRAND"] == null)
                    {
                        AppStart.GetBrand();
                    }
                    strCache = "BRAND";
                    break;
            }
            myControl.Items.Clear();
            myControl.DataTextField = TextField;
            myControl.DataValueField = ValueField;
            myControl.DataSource = (DataSet)HttpContext.Current.Cache[strCache];
            myControl.DataBind();
        }
        private static void SetTableBind(GridView myGrid)
        {
 
        }

        // Add dwi 20130516
        public static void BindDataSetToCombo(DropDownList myControl, String preText, String sqlQuery, String sqlValue, String sqlField, String selValue)
        {
            SQLHandler sh = new SQLHandler();
            DataSet ds = new DataSet();
                    
            try {
                myControl.Items.Clear();
                
                ds = sh.ExecuteAsDataSet(sqlQuery);

                if (preText != null)
                {
                    ListItem lstItem = new ListItem();
                    lstItem.Text = preText;
                    lstItem.Value = "";
                    myControl.Items.Add(lstItem);
                }


                foreach (DataRow dr in ds.Tables[0].Rows) {
                    ListItem lstItem = new ListItem();
                    lstItem.Text = dr[sqlField].ToString();
                    lstItem.Value = dr[sqlValue].ToString();
                    myControl.Items.Add(lstItem);
                }

                if (selValue != null) {
                    ListItem selItem = myControl.Items.FindByValue(selValue);
                    if (selItem != null) {
                        selItem.Selected = true;
                    }
                }
            } catch {
                throw;
            }
        }
    }
}
