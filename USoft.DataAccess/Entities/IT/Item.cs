using System;
using System.Collections.Generic;
using System.Text;

namespace USoft.DataAccess.Entities.IT
{
    public class Item : USoft.DataAccess.Entities.General
    {
        // Member
        private string _item_code;
        private string _item_name;
        private string _condition_name;
        private int _StatusOut;
        private string _used_by;
        private string _privilege_code;
        private string _privilege_name;
        private string _receive_type;

        private string _item_in_code;
        private DateTime _date;
        private int _branch_id;
        private string _supplier_code;
        private string _supplier_name;
        private string _pic;
        private string _pic_name;
        private string _UserName;
        private string _Status;

        private string _item_in_detail_code;
        private string _ItemTypeCode;
        private string _ItemTypeName;
        private int _status_in;
        //private string _old_serial_no;
        private string _serial_no;
        private string _barcode;
        private int _condition_code;
        
        private string _item_trans_code;
        private string _item_trans_detail_code;
        private int _branch_id_from; 
        private string _branch_name_from;
        private int _branch_id_to;
        private string _branch_name_to;
        private DateTime _date_trans;

        private string _item_out_code;
        private string _item_out_detail_code; ////////
        private bool _isreturn;
        private bool _isreplace;
        private string _repair_status;
        private string _remark;


        private int _repair_condition;////
        private string _repair_condition_name;////
        private string _repair_description;////


        // Method
        public string ItemCode
        {
            get { return _item_code; }
            set { _item_code = value; }
        }

        public string ItemName
        {
            get { return _item_name; }
            set { _item_name = value; }
        }

        public string ItemInCode
        {
            get { return _item_in_code; }
            set { _item_in_code = value; }
        }

        public string ItemInDetailCode
        {
            get { return _item_in_detail_code; }
            set { _item_in_detail_code = value; }
        }

        public string ItemOutDetailCode  ////////
        {
            get { return _item_out_detail_code; }
            set { _item_out_detail_code = value; }
        }

        public string ItemTransCode
        {
            get { return _item_trans_code; }
            set { _item_trans_code = value; }
        }

        public string ItemTransDetailCode
        {
            get { return _item_trans_detail_code; }
            set { _item_trans_detail_code = value; }
        }

        public DateTime Date
        {
            get { return _date; }
            set { _date = value; }
        }

        public string ReceiveType
        {
            get { return _receive_type; }
            set { _receive_type = value; }
        }

        public string PIC
        {
            get { return _pic; }
            set { _pic = value; }
        }

        public string PICName
        {
            get { return _pic_name; }
            set { _pic_name = value; }
        }

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        public int StatusIn //New,Return,Replace
        {
            get { return _status_in; }
            set { _status_in = value; }
        }

        public int StatusOut //Repair,Dispose,Return,Replace
        {
            get { return _StatusOut; }
            set { _StatusOut = value; }
        }

        public string Status //D,R,A
        {
            get { return _Status; }
            set { _Status = value; }
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

        //public string OldSerialNo
        //{
        //    get { return _old_serial_no; }
        //    set { _old_serial_no = value; }
        //}

        public string SerialNo
        {
            get { return _serial_no; }
            set { _serial_no = value; }
        }

        public string Barcode
        {
            get { return _barcode; }
            set { _barcode = value; }
        }

        public int ConditionCode
        {
            get { return _condition_code; }
            set { _condition_code = value; }
        }

        public string ConditionName
        {
            get { return _condition_name; }
            set { _condition_name = value; }
        }

        public string UsedBy
        {
            get { return _used_by; }
            set { _used_by = value; }
        }

        public string PrivilegeCode
        {
            get { return _privilege_code; }
            set { _privilege_code = value; }
        }

        public string PrivilegeName
        {
            get { return _privilege_name; }
            set { _privilege_name = value; }
        }

        public int BranchIdFrom
        {
            get { return _branch_id_from; }
            set { _branch_id_from = value; }
        }
        public string BranchNameFrom
        {
            get { return _branch_name_from; }
            set { _branch_name_from = value; }
        }

        public int BranchIdTo
        {
            get { return _branch_id_to; }
            set { _branch_id_to = value; }
        }
        public string BranchNameTo
        {
            get { return _branch_name_to; }
            set { _branch_name_to = value; }
        }
        
        public DateTime TransDate
        {
            get { return _date_trans; }
            set { _date_trans = value; }
        }

        public String ItemOutCode
        {
            get { return _item_out_code; }
            set { _item_out_code = value; }
        }

        public String SupplierCode
        {
            get { return _supplier_code; }
            set { _supplier_code = value; }
        }

        public String SupplierName
        {
            get { return _supplier_name; }
            set { _supplier_name = value; }
        }

        public bool IsReturn
        {
            get { return _isreturn; }
            set { _isreturn = value; }
        }

        public bool IsReplace
        {
            get { return _isreplace; }
            set { _isreplace = value; }
        }

        public string RepairStatus
        {
            get { return _repair_status; }
            set { _repair_status = value; }
        }

        public string Remark
        {
            get { return _remark; }
            set { _remark = value; }
        }

        public int RepairCondition ////
        {
            get { return _repair_condition; }
            set { _repair_condition = value; }
        }

        public string RepairConditionName ////
        {
            get { return _repair_condition_name; }
            set { _repair_condition_name = value; }
        }

        public string RepairDescription ////
        {
            get { return _repair_description; }
            set { _repair_description = value; }
        }
    }
}
