using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Marketing
{
    public class CashRewardDetail : USoft.DataAccess.Entities.General
    {
        #region variable
        private string _refundRecipientId;
        private string _recipientName;
        private string _position;
        private string _bankName;
        private string _bankLocation;
        private string _accountName;
        private string _accountNumber;
        private string _npwp;
        private string _taxTypeCode;
        private string _recipientAmount;
        private string _taxAmount;
        private string _netAmount;
        #endregion
        
        #region Method
        public string RefundRecipientId
        {
            get { return _refundRecipientId; }
            set { _refundRecipientId = value; }
        }
        public string RecipientName
        {
            get { return _recipientName; }
            set { _recipientName = value; }
        }
        public string Position
        {
            get { return _position; }
            set { _position = value; }
        }
        public string BankName
        {
            get { return _bankName; }
            set { _bankName = value; }
        }
        public string BankLocation
        {
            get { return _bankLocation; }
            set { _bankLocation = value; }
        }
        public string AccountName
        {
            get { return _accountName; }
            set { _accountName = value; }
        }
        public string AccountNumber
        {
            get { return _accountNumber; }
            set { _accountNumber = value; }
        }
        public string Npwp
        {
            get { return _npwp; }
            set { _npwp = value; }
        }
        public string TaxTypeCode
        {
            get { return _taxTypeCode; }
            set { _taxTypeCode = value; }
        }
        public string RecipientAmount
        {
            get { return _recipientAmount; }
            set { _recipientAmount = value; }
        }
        public string TaxAmount
        {
            get { return _taxAmount; }
            set { _taxAmount = value; }
        }
        public string NetAmount
        {
            get { return _netAmount; }
            set { _netAmount = value; }
        }
        #endregion Method
    }
}
