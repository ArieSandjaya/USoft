using System;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Reflection;
using System.Data;
using System.Data.SqlClient;
using USoft.Common;
using System.Collections.Generic;

namespace USoft.Classes
{
    public class BasePageSearch:BasePage
    {
        #region Constants
			private const string SESSIONSTATE_PAGINATED_LIST			= "SESSIONSTATE_PAGINATED_LIST";
			private const string SESSIONSTATE_SEARCH_PARAMETER_DOMAIN	= "SESSIONSTATE_SEARCH_PARAMETER_DOMAIN";
		#endregion

        #region Declared Property
            protected string ValData
            {
                get
                {
                    return  Session["UserId"].ToString()+"~"+this.Request.QueryString["validate"].ToString();
                }
            }
            protected bool isInsertAllowed
			{	
                get 
                { 
                    return (Common.Security.FormSecurity.isInsertAllowed(ValData));
                }
			}
            protected bool isUpdateAllowed
			{	
                get 
                { 
                    return (Common.Security.FormSecurity.isUpdateAllowed(ValData));
                }
			}
            protected bool isDeleteAllowed
			{	
                get 
                { 
                    return (Common.Security.FormSecurity.isDeleteAllowed(ValData));
                }
			}
            protected bool isViewAllowed
			{	
                get 
                { 
                    return (Common.Security.FormSecurity.isViewAllowed(ValData));
                }
			}
            protected int PagingSize
            {
                get
                {
                    return(USoft.Common.Setting.SystemSetting.PagingSize);
                }
            }
            protected USoft.DataAccess.Entities.UserInfo PageProperty
			    {
				    get{return null;}
			    }
        #endregion

            #region Declared Method
            protected void SearchHeaderData(object domain,object SQLDomain,string ViewName)
            {
                Type type  = domain.GetType();
                PropertyInfo property = type.GetProperty("WhereIs");
                object PropertyName = property.GetValue(domain,(object[]) null);

                Type SQLType = SQLDomain.GetType();
                MethodInfo SQLMethode = SQLType.GetMethod(ViewName);

                object classInstance = Activator.CreateInstance(SQLType,null);

                DataSet ds = new DataSet();

                ds = (DataSet)SQLMethode.Invoke(classInstance, new object[] { domain });

                //sH.SetDataToObject((DataSet)SQLMethode.Invoke(domain, new object[] { myobject }), myobject);
            }
            protected void SearchData(object domain,object SQLDomain,string ViewName,GridView ViewGrid,UserControl ucGridPager)
			{
                Type type  = domain.GetType();
                PropertyInfo property = type.GetProperty("WhereIs");
                object PropertyName = property.GetValue(domain,(object[]) null);

                Type SQLType = SQLDomain.GetType();
                MethodInfo SQLMethode = SQLType.GetMethod(ViewName);
                
                object classInstance = Activator.CreateInstance(SQLType,null);

                    ViewGrid.DataSource = SQLMethode.Invoke(classInstance,new object[] {domain});
                    
                    Type ucGridPagerType = ucGridPager.GetType();
                    String pPageNo = Convert.ToString(type.GetProperty("PageNo").GetValue(domain,(object[])null));
                    String pTotalPage = Convert.ToString(type.GetProperty("TotalPage").GetValue(domain,(object[])null));
                    String pTotalData = Convert.ToString(type.GetProperty("TotalData").GetValue(domain,(object[])null));

                    ucGridPagerType.GetProperty("CurrPage").SetValue(ucGridPager,pPageNo,null);
                    ucGridPagerType.GetProperty("TotalPage").SetValue(ucGridPager,pTotalPage,null);
                    ucGridPagerType.GetProperty("TotalData").SetValue(ucGridPager,pTotalData,null);
      
                    MethodInfo mGridPager = ucGridPagerType.GetMethod("ButtonState");
                    mGridPager.Invoke(ucGridPager,(object[])null);

                    ucGridPager.Visible = (Convert.ToInt32(pTotalData) > this.PagingSize);
                    ViewGrid.DataBind();
			}
            #endregion
        }
}
