using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities
{
    public class Email
    {
        private string _UserName;
        private string _EmailAddress;

        // Method
        public Email(string UserName, string EmailAddress)
        {
            this.UserName = UserName;
            this.EmailAddress = EmailAddress;
        }
        
        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        public string EmailAddress
        {
            get { return _EmailAddress; }
            set { _EmailAddress = value; }
        }
    }
}
