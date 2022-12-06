using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.General_Affair
{
    public class Purchase : USoft.DataAccess.Entities.General
    {
        // Member
        private string _IDNumber;
        private string _RequestId;
        private DateTime _RequestDate;
        private string _OrderId;
        private DateTime _OrderDate;
        private string _ReceivedId;
        private DateTime _ReceivedDate;
        private DateTime _DeliveryDate;
        private string _PIC;
        private string _Type;
        private string _Reason;
        private string _SupplierCode;
        private string _SupplierName;
        private string _OfferFrom;
        private string _OfferNo;
        private DateTime _OfferDate;
        private string _Status;

        private string _RequestDetailId;
        private string _OrderDetailId;
        private string _ReceivedDetailId;
        private string _ItemCategoryCode;
        private string _ItemCategoryName;
        private string _ItemGroupCode;
        private string _ItemGroupName;
        private string _ItemTypeCode;
        private string _ItemTypeName;
        private Double _Quantity;
        private Double _RequestQty;
        private Double _CurrentQty;
        private string _MeasurementCode;
        private Double _Price;
        private string _CurrencyCode;
        private Double _Total;

        // Method
        public string IDNumber
        {
            get { return _IDNumber; }
            set { _IDNumber = value; }
        }

        public string RequestId
        {
            get { return _RequestId; }
            set { _RequestId = value; }
        }

        public DateTime RequestDate
        {
            get { return _RequestDate; }
            set { _RequestDate = value; }
        }

        public string OrderId
        {
            get { return _OrderId; }
            set { _OrderId = value; }
        }

        public DateTime OrderDate
        {
            get { return _OrderDate; }
            set { _OrderDate = value; }
        }

        public string ReceivedId
        {
            get { return _ReceivedId; }
            set { _ReceivedId = value; }
        }

        public DateTime ReceivedDate
        {
            get { return _ReceivedDate; }
            set { _ReceivedDate = value; }
        }

        public DateTime DeliveryDate
        {
            get { return _DeliveryDate; }
            set { _DeliveryDate = value; }
        }

        public string PIC
        {
            get { return _PIC; }
            set { _PIC = value; }
        }

        public string Type
        {
            get { return _Type; }
            set { _Type = value; }
        }

        public string Reason
        {
            get { return _Reason; }
            set { _Reason = value; }
        }

        public string SupplierCode
        {
            get { return _SupplierCode; }
            set { _SupplierCode = value; }
        }

        public string SupplierName
        {
            get { return _SupplierName; }
            set { _SupplierName = value; }
        }

        public string OfferFrom
        {
            get { return _OfferFrom; }
            set { _OfferFrom = value; }
        }

        public string OfferNo
        {
            get { return _OfferNo; }
            set { _OfferNo = value; }
        }

        public DateTime OfferDate
        {
            get { return _OfferDate; }
            set { _OfferDate = value; }
        }

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        public string RequestDetailId
        {
            get { return _RequestDetailId; }
            set { _RequestDetailId = value; }
        }

        public string OrderDetailId
        {
            get { return _OrderDetailId; }
            set { _OrderDetailId = value; }
        }

        public string ReceivedDetailId
        {
            get { return _ReceivedDetailId; }
            set { _ReceivedDetailId = value; }
        }

        public string ItemCategoryCode
        {
            get { return _ItemCategoryCode; }
            set { _ItemCategoryCode = value; }
        }

        public string ItemCategoryName
        {
            get { return _ItemCategoryName; }
            set { _ItemCategoryName = value; }
        }

        public string ItemGroupCode
        {
            get { return _ItemGroupCode; }
            set { _ItemGroupCode = value; }
        }

        public string ItemGroupName
        {
            get { return _ItemGroupName; }
            set { _ItemGroupName = value; }
        }

        public string ItemTypeCode
        {
            get { return _ItemTypeCode; }
            set { _ItemTypeCode = value; }
        }

        public string ItemTypeName
        {
            get { return _ItemTypeName; }
            set { _ItemTypeName = value; }
        }

        public Double Quantity
        {
            get { return _Quantity; }
            set { _Quantity = value; }
        }

        public Double RequestQty
        {
            get { return _RequestQty; }
            set { _RequestQty = value; }
        }

        public Double CurrentQty
        {
            get { return _CurrentQty; }
            set { _CurrentQty = value; }
        }

        public string MeasurementCode
        {
            get { return _MeasurementCode; }
            set { _MeasurementCode = value; }
        }

        public Double Price
        {
            get { return _Price; }
            set { _Price = value; }
        }

        public string CurrencyCode
        {
            get { return _CurrencyCode; }
            set { _CurrencyCode = value; }
        }

        public Double Total
        {
            get { return _Total; }
            set { _Total = value; }
        }
    }
}
