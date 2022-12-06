using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.CommonFunction;
using USoft.Common.Shared;

namespace USoft.Globalization
{
    public class UserMenu
    {
        private string _userId;
        private int _menuId;
        private int _InsertDt;
        private int _UpdateDt;
        private int _DeleteDt;
        private int _ViewDt;
        private string _privCode; ////////
        
        public UserMenu()
        { }
        public DataSet GetAllMenu()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", _userId));
            return sqlHandler.ExecuteAsDataSet("MsMenuGetAll", ParameterCollection);
        }
        public void SaveUserMenu()
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserId", _userId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@MenuId", _menuId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@InsertDt", _InsertDt));
            ParameterCollection.Add(new KeyValuePair<string, object>("@UpdateDt", _UpdateDt));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DeleteDt", _DeleteDt));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ViewDt", _ViewDt));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PrivCode", _privCode)); ////////
            sqlHandler.ExecuteNonQuery("MsUserPriveledge", ParameterCollection);
        }
        

        public string UserID
        {
            set { _userId = value; }
        }
        public int MenuId
        {
            set { _menuId = value; }
        }
        public int Insert
        {
            set { _InsertDt = value; }
        }
        public int Update
        {
            set { _UpdateDt = value; }
        }
        public int Delete
        {
            set { _DeleteDt = value; }
        }
        public int View
        {
            set { _ViewDt = value; }
        }
        public string PrivCode //////////
        {
            get { return _privCode; }
            set { _privCode = value; }
        }
    }
}
