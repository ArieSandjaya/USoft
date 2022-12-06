using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.Marketing
{
    public class CashReward: USoft.DataAccess.Entities.General
    {
        #region Variable
            private string _ContractNumber;
            private string _SupplierType;
            private string _SupplierCode;
            private string _BrandCode;
            private string _BrandName;
            private string _Condition;
            private string _SupplierName;
            private string _BranchCode;
            private string _BranchParentCode;
            private DateTime _CommenceProcessDate;
            private string _CustomerName;
            private double _DpRate;
            private int _ContractTerm;
            private string _PaymentDueTypeCode;
            private double _FlatInputRate;
            private string _CarType;
            private string _CarTypeName;
            private string _BrandItemName;
            private string _InsuranceName;
            private double _AdminFee;
            private string _Eligible;
            private double _AmountReward;
        #endregion
        #region Method
                public string ContractNumber
                    {
                        get{ return _ContractNumber; }
                        set{ _ContractNumber = value; }
                    }
                public string SupplierType
                    {
                        get{ return _SupplierType; }
                        set{ _SupplierType = value; }
                    }
                public string SupplierCode
                    {
                        get{ return _SupplierCode; }
                        set{ _SupplierCode = value; }
                    }
                public string BrandCode
                    {
                        get{ return _BrandCode; }
                        set{ _BrandCode = value; }
                    }
                public string BrandName
                    {
                        get{ return _BrandName; }
                        set{ _BrandName = value; }
                    }
                public string Condition
                    {
                        get{ return _Condition; }
                        set{ _Condition = value; }
                    }
                public string SupplierName
                    {   
                        get{ return _SupplierName; }
                        set{ _SupplierName = value; }
                    }
                public string BranchCode
                    {
                        get{ return _BranchCode; }
                        set{ _BranchCode = value; }
                    }
                public string BranchParentCode
                    {
                        get{ return _BranchParentCode; }
                        set{ _BranchParentCode = value; }
                    }
                public DateTime CommenceProcessDate
                    {
                        get{ return _CommenceProcessDate; }
                        set{ _CommenceProcessDate = value; }
                    }
                public string CustomerName
                    {
                        get{ return _CustomerName; }
                        set{ _CustomerName = value; }
                    }
                public double DpRate
                    {
                        get{ return _DpRate; }
                        set{ _DpRate = value; }
                    }
                public int ContractTerm
                    {
                        get{ return _ContractTerm; }
                        set{ _ContractTerm = value; }
                    }
                public string PaymentDueTypeCode
                    {
                        get{ return _PaymentDueTypeCode; }
                        set{ _PaymentDueTypeCode = value; }
                    }
                public double FlatInputRate
                    {
                        get{ return _FlatInputRate; }
                        set{ _FlatInputRate = value; }
                    }
                public string CarType
                    {
                        get{ return _CarType; }
                        set{ _CarType = value; }
                    }
                public string CarTypeName
                    {
                        get{ return _CarTypeName; }
                        set{ _CarTypeName = value; }
                    }
                public string BrandItemName
                    {
                        get{ return _BrandItemName; }
                        set{ _BrandItemName = value; }
                    }
                public string InsuranceName
                    {
                        get{ return _InsuranceName; }
                        set{ _InsuranceName = value; }
                    }
                public double AdminFee
                    {
                        get{ return _AdminFee; }
                        set{ _AdminFee = value; }
                    }
                public string Eligible
                    {
                        get{ return _Eligible; }
                        set{ _Eligible = value; }
                    }
                public double AmountReward
                    {
                        get{ return _AmountReward; }
                        set{ _AmountReward = value; }
                    }
    #endregion
        }
}
