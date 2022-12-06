using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Net.Mime;

using USoft.Common.Shared;
using USoft.Common.CommonFunction;
using USoft.Common.Setting;

namespace USoft.DataAccess.General
{
    public class Email
    {
        // Parameter
        string piintMenuId = "@piintMenuId";
        string piintState = "@piintState";
        string pivchUserId = "@pivchUserId";

        // Store Procedure
        string spGetMappingApprovalEmailTo = "spGetMappingApprovalEmailTo";
        string spGetUserEmail = "spGetUserEmail";

        // Field Name
        string UserName = "UserName";
        string EmailAddress = "Email";

        public void getMappingApprovalEmailTo(ref List<USoft.DataAccess.Entities.Email> EmailTo, string MenuId, int State)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(piintMenuId, MenuId));
            ParameterCollection.Add(new KeyValuePair<string, object>(piintState, State));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGetMappingApprovalEmailTo, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        foreach (USoft.DataAccess.Entities.Email MailTo in EmailTo)
                        {
                            if (dr[EmailAddress].ToString() == MailTo.EmailAddress) { goto IsExists; }
                        }

                        EmailTo.Add(new USoft.DataAccess.Entities.Email(dr[UserName].ToString().Trim(), dr[EmailAddress].ToString().Trim()));

                        IsExists:
                            continue;
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public string getUserEmail(string UserId)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            String MailAddress = null;

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, UserId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGetUserEmail, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        MailAddress = dr[EmailAddress].ToString();
                    }
                }
                dr.Close();
            }
            catch
            { throw; }

            return MailAddress;
        }

        public void getUserEmail(ref List<USoft.DataAccess.Entities.Email> UserEmail, string UserId)
        {
            SqlDataReader dr;
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>(pivchUserId, UserId));

            try
            {
                dr = sqlHandler.ExecuteAsDataReader(spGetUserEmail, ParameterCollection);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        foreach (USoft.DataAccess.Entities.Email MailTo in UserEmail)
                        {
                            if (dr[EmailAddress].ToString() == MailTo.EmailAddress) { goto IsExists; }
                        }

                        UserEmail.Add(new USoft.DataAccess.Entities.Email(dr[UserName].ToString().Trim(), dr[EmailAddress].ToString().Trim()));

                        IsExists:
                            continue;
                    }
                }
                dr.Close();
            }
            catch
            { throw; }
        }

        public string sendEmail(
                List<USoft.DataAccess.Entities.Email> From,
                List<USoft.DataAccess.Entities.Email> To,
                List<USoft.DataAccess.Entities.Email> CC,
                string Subject,
                string Body,
                bool isHTML
            )
        {
            string msg;
            
            try
            {
                MailMessage mailMsg = new MailMessage();

                if (From.Count > 0)
                {
                    mailMsg.From = new MailAddress(From[0].EmailAddress, From[0].UserName);
                }
                else
                {
                    mailMsg.From = new MailAddress(SystemSetting.MailAgentAddress, SystemSetting.MailAgentName);
                }

                foreach (USoft.DataAccess.Entities.Email MailTo in To)
                {
                    mailMsg.To.Add(new MailAddress(MailTo.EmailAddress, MailTo.UserName));
                }

                foreach (USoft.DataAccess.Entities.Email MailCC in CC)
                {
                    foreach (USoft.DataAccess.Entities.Email MailTo in To)
                    {
                        if (MailCC.EmailAddress == MailTo.EmailAddress) { goto IsExists; }
                    }                    

                    mailMsg.CC.Add(new MailAddress(MailCC.EmailAddress, MailCC.UserName));

                    IsExists:
                        continue;
                }

                mailMsg.Subject = Subject;
                mailMsg.Body = Body;
                mailMsg.IsBodyHtml = isHTML;

                SmtpClient client = new SmtpClient(SystemSetting.MailHostUfindo, SystemSetting.Port);
                if (mailMsg.To.Count > 0)
                {
                    client.Send(mailMsg);
                    msg = "Message Sent";
                }
                else
                {
                    msg = "No E-Mail Destination";
                }
            }
            catch (Exception ex)
            {
                msg = "Failed Send Message : " + ex.ToString();
            }

            return msg;
        }
    }
}
