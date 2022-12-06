using System;
using System.Collections.Generic;
using System.Text;
using USoft.Common.Shared;
using System.Data;

namespace USoft.Compliance.Entertainment
{
    public class SaveEntertainment
    {
        private static int _keyId;
        private static string _appName;
        private static string _bankName;
        private static string _accName;
        private static string _accNo;
        private static string _branch;
        private static string _acceptanceOffer;
        private static string _lineBussines;
        private static int _counterParty;
        private static string _cPartyName;
        private static string _purpose;
        private static int _events;
        private static string _place;
        private static string _date;
        private static string _time;
        private static string _ourAttendee;
        private static string _counterAttendee;
        private static decimal _estBudget;
        private static decimal _totalAmount;
        private static string _reason;
        private static string _receiptNo;
        private static string _participant1;
        private static decimal _percentage1;
        private static string _participant2;
        private static decimal _percentage2;
        private static string _participant3;
        private static decimal _percentage3;
        private static int _antiSocialCheck;
        private static string _reasonAnti;
        private static string _userName;
        private static string _dept;
        private static string _regulerSudden;
        private static string _companyJPN;
        private static string _comments;
        private static int _oriReceipt;
        private static string _inputDate;
        public SaveEntertainment()
        { }
        public string[] Save()
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
                ParameterCollection.Add(new KeyValuePair<string, object>("@ApplName", _appName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@BankName", _bankName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@AccName", _accName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@AccNo", _accNo));
                ParameterCollection.Add(new KeyValuePair<string, object>("@ddlBranch", _branch));
                ParameterCollection.Add(new KeyValuePair<string, object>("@rdAcceptanceOffer", _acceptanceOffer));
                ParameterCollection.Add(new KeyValuePair<string, object>("@LineBussines", _lineBussines));
                ParameterCollection.Add(new KeyValuePair<string, object>("@rdCounterparty", _counterParty));
                ParameterCollection.Add(new KeyValuePair<string, object>("@CountpartyName", _cPartyName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Purpose", _purpose));
                ParameterCollection.Add(new KeyValuePair<string, object>("@RdEvents", _events));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Place", _place));
                ParameterCollection.Add(new KeyValuePair<string, object>("@datepicker", _date));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Time", _time));
                ParameterCollection.Add(new KeyValuePair<string, object>("@OurAttendee", _ourAttendee));
                ParameterCollection.Add(new KeyValuePair<string, object>("@CounterAttendee", _counterAttendee));
                ParameterCollection.Add(new KeyValuePair<string, object>("@EstBudget", _estBudget));
                ParameterCollection.Add(new KeyValuePair<string, object>("@TotalAmount", _totalAmount));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Reason", _reason));
                ParameterCollection.Add(new KeyValuePair<string, object>("@ReceiptNo", _receiptNo));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Participant1", _participant1));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Percentage1", _percentage1));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Participant2", _participant2));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Percentage2", _percentage2));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Participant3", _participant3));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Percentage3", _percentage3));
                ParameterCollection.Add(new KeyValuePair<string, object>("@rdAntiSocialCheck", _antiSocialCheck));
                ParameterCollection.Add(new KeyValuePair<string, object>("@ReasonAnti", _reasonAnti));
                ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", _userName));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Dept", _dept));
                ParameterCollection.Add(new KeyValuePair<string, object>("@rdlRegulerSudden", _regulerSudden));
                ParameterCollection.Add(new KeyValuePair<string, object>("@CompanyJPN", _companyJPN));
                ParameterCollection.Add(new KeyValuePair<string, object>("@Comments", _comments));
                ParameterCollection.Add(new KeyValuePair<string, object>("@OriReceiptAttach", _oriReceipt));
                ParameterCollection.Add(new KeyValuePair<string, object>("@CreateDate", _inputDate));
                DataTable dt = sqlHandler.ExecuteAsDataTable("ENTERTAINMENT_GIFT_INSERT", ParameterCollection);
                string[] myString = new string[2];
                myString[0] = dt.Rows[0].ItemArray[0].ToString();
                myString[1] = dt.Rows[0].ItemArray[1].ToString();
                return myString;
            }
            catch
            {
                return null;
            }
        }
        public void Edit()
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@KeyID", _keyId));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ApplName", _appName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@BankName", _bankName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@AccName", _accName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@AccNo", _accNo));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ddlBranch", _branch));
            ParameterCollection.Add(new KeyValuePair<string, object>("@rdAcceptanceOffer", _acceptanceOffer));
            ParameterCollection.Add(new KeyValuePair<string, object>("@LineBussines", _lineBussines));
            ParameterCollection.Add(new KeyValuePair<string, object>("@rdCounterparty", _counterParty));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CountpartyName", _cPartyName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Purpose", _purpose));
            ParameterCollection.Add(new KeyValuePair<string, object>("@RdEvents", _events));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Place", _place));
            ParameterCollection.Add(new KeyValuePair<string, object>("@datepicker", _date));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Time", _time));
            ParameterCollection.Add(new KeyValuePair<string, object>("@OurAttendee", _ourAttendee));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CounterAttendee", _counterAttendee));
            ParameterCollection.Add(new KeyValuePair<string, object>("@EstBudget", _estBudget));
            ParameterCollection.Add(new KeyValuePair<string, object>("@TotalAmount", _totalAmount));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Reason", _reason));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ReceiptNo", _receiptNo));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Participant1", _participant1));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Percentage1", _percentage1));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Participant2", _participant2));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Percentage2", _percentage2));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Participant3", _participant3));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Percentage3", _percentage3));
            ParameterCollection.Add(new KeyValuePair<string, object>("@rdAntiSocialCheck", _antiSocialCheck));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ReasonAnti", _reasonAnti));
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", _userName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Dept", _dept));
            ParameterCollection.Add(new KeyValuePair<string, object>("@rdlRegulerSudden", _regulerSudden));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CompanyJPN", _companyJPN));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Comments", _comments));
            ParameterCollection.Add(new KeyValuePair<string, object>("@OriReceiptAttach", _oriReceipt));
            ParameterCollection.Add(new KeyValuePair<string, object>("@CreateDate", _inputDate));
            sqlHandler.ExecuteNonQuery("ENTERTAINMENT_GIFT_UPDATE", ParameterCollection);
        }
        public string AppName
        {
            set { _appName = value; }
        }
        public string BankName
        {
            set { _bankName = value; }
        }
        public string AccName
        {
            set { _accName = value; }
        }
        public string AccNo
        {
            set { _accNo = value; }
        }
        public string Branch
        {
            set { _branch = value; }
        }
        public string AcceptanceOffer
        {
            set { _acceptanceOffer = value; }
        }
        public string LineBussines
        {
            set { _lineBussines = value; }
        }
        public int CounterParty
        {
            set { _counterParty = value; }
        }
        public string CPartyName
        {
            set { _cPartyName = value; }
        }
        public string Purpose
        {
            set { _purpose = value; }
        }
        public int Events
        {
            set { _events = value; }
        }
        public string Place
        {
            set { _place = value; }
        }
        public string Date
        {
            set { _date = value; }
        }
        public string Time
        {
            set { _time = value; }
        }
        public string OurAttendee
        {
            set { _ourAttendee = value; }
        }
        public string CounterAttendee
        {
            set { _counterAttendee = value; }
        }
        public decimal EstBudget
        {
            set { _estBudget = value; }
        }
        public decimal TotalAmount
        {
            set { _totalAmount = value; }
        }
        public string Reason
        {
            set { _reason = value; }
        }
        public string ReceiptNo
        {
            set { _receiptNo = value; }
        }
        public string Participant1
        {
            set { _participant1 = value; }
        }
        public decimal Percentage1
        {
            set { _percentage1 = value; }
        }
        public string Participant2
        {
            set { _participant2 = value; }
        }
        public decimal Percentage2
        {
            set { _percentage2 = value; }
        }
        public string Participant3
        {
            set { _participant3 = value; }
        }
        public decimal Percentage3
        {
            set { _percentage3 = value; }
        }
        public int AntiSocialCheck
        {
            set { _antiSocialCheck = value; }
        }
        public string ReasonAnti
        {
            set { _reasonAnti = value; }
        }
        public string UserName
        {
            set { _userName = value; }
        }
        public string Dept
        {
            set { _dept = value; }
        }
        public string RegulerSudden
        {
            set { _regulerSudden = value; }
        }
        public string CompanyJPN
        {
            set { _companyJPN = value; }
        }
        public string Comments
        {
            set { _comments = value; }
        }
        public int OriReceipt
        {
            set { _oriReceipt = value; }
        }
        public string InputDate
        {
            set { _inputDate = value; }
        }
        public int KeyId
        {
            set { _keyId = value; }
        }
    }
}
