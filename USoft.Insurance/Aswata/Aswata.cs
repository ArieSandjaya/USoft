using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.Insurance.Aswata
{
    public class Aswata
    {
        public Aswata()
        { }
        public DataSet GetAswata(int Branch,DateTime DateFrom,DateTime DateTo)
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string,object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@BranchId", Branch));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DateStart", cf.DateNormalize(DateFrom)));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DateEnd",cf.DateNormalize(DateTo)));
            return sqlHandler.ExecuteAsDataSet("INSURANCE_ASWATA", ParameterCollection);
        }
        public void ConvertAswata(DataSet ds)
        {
            CommonFunction cf = new CommonFunction();
            string str;
            str = "CommenceDate|ContractNo|Branch ID|CustomerName|CustomerAddress|StartDate|EndDate|Usage|AssetName|AssetYear|AssetColor|AssetPoliceNo|AssetChassisNo|AssetEngineNo|AdditionalEquipment|SumInsuredTh1|CoverageTypeCodeTh1|Tplth1|RSCC1|RSMD1|AOG1|Flood1|EarthQuake1|InsLength1|SumInsuredTh2|CoverageTypeCodeTh2|Tplth2|RSCC2|RSMD2|AOG2|Flood2|EarthQuake2|InsLength2|SumInsuredTh3|CoverageTypeCodeTh3|Tplth3|RSCC3|RSMD3|AOG3|Flood3|EarthQuake3|InsLength3|SumInsuredTh4|CoverageTypeCodeTh4|Tplth4|RSCC4|RSMD4|AOG4|Flood4|EarthQuake4|InsLength4|SumInsuredTh5|CoverageTypeCodeTh5|Tplth5|RSCC5|RSMD5|AOG5|Flood5|EarthQuake5|InsLength5|SumInsuredType|ClosingStatus|\r\n";
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                str = str + dr["commence_date"].ToString().Trim() + "|" + dr["ContractNo"].ToString().Trim() + "|" + dr["branch_id"].ToString().Trim() + "|" +  dr["customer_name"].ToString().Trim() + "QQ" + dr["BPKB_name"].ToString().Trim() + "|" + dr["full_address"].ToString().Trim() + "|" + dr["StartDate"].ToString().Trim() + "|" + dr["EndDate"].ToString().Trim() + "|" + dr["Usage"].ToString().Trim() + "|" + dr["brand"].ToString().Trim() + "-" + dr["type_mobil"].ToString().Trim() + "|" +  dr["thnbuat"].ToString().Trim() + "|" + dr["Warna_kendaraan"].ToString().Trim() + "|" + dr["no_polisi"].ToString().Trim() + "|" +  dr["No_Rangka_kendaraan"].ToString().Trim() + "|" + dr["No_Mesin_Kendaraan"].ToString().Trim() + "|" + dr["accesories"].ToString().Trim() + "|";
                str = str + dr["Tahun_I"].ToString().Trim() + "|" + dr["coverage_I"].ToString().Trim() + "|" + dr["tjhth1"].ToString().Trim() + "|" + dr["RSCC1"].ToString().Trim() + "|" + dr["RSMD1"].ToString().Trim() + "|" + dr["AOG1"].ToString().Trim() + "|" + dr["Flood1"].ToString().Trim() + "|" + dr["EarthQuake1"].ToString().Trim() + "|" + dr["InsLength1"].ToString().Trim() + "|" + dr["Tahun_II"].ToString().Trim() + "|" + dr["coverage_II"].ToString().Trim() + "|" + dr["tjhth2"].ToString().Trim() + "|" + dr["RSCC2"].ToString().Trim() + "|" + dr["RSMD2"].ToString().Trim() + "|" + dr["AOG2"].ToString().Trim() + "|" + dr["Flood2"].ToString().Trim() + "|" + dr["EarthQuake2"].ToString().Trim() + "|" + dr["InsLength2"].ToString().Trim() + "|" + dr["Tahun_III"].ToString().Trim() + "|" + dr["coverage_III"].ToString().Trim() + "|" + dr["tjhth3"].ToString().Trim() + "|" + dr["RSCC3"].ToString().Trim() + "|" + dr["RSMD3"].ToString().Trim() + "|" + dr["AOG3"].ToString().Trim() + "|" + dr["Flood3"].ToString().Trim() + "|" + dr["EarthQuake3"].ToString().Trim() + "|" + dr["InsLength3"].ToString().Trim() + "|" + dr["Tahun_IV"].ToString().Trim() + "|" + dr["coverage_IV"].ToString().Trim() + "|" + dr["tjhth4"].ToString().Trim() + "|" + dr["RSCC4"].ToString().Trim() + "|" + dr["RSMD4"].ToString().Trim() + "|" + dr["AOG4"].ToString().Trim() + "|" + dr["Flood4"].ToString().Trim() + "|" + dr["EarthQuake4"].ToString().Trim() + "|" + dr["InsLength4"].ToString().Trim() + "|";
                str = str + dr["Tahun_V"].ToString().Trim() + "|" + dr["coverage_V"].ToString().Trim() + "|" + dr["tjhth5"].ToString().Trim() + "|" + dr["RSCC5"].ToString().Trim() + "|" + dr["RSMD5"].ToString().Trim() + "|" + dr["AOG5"].ToString().Trim() + "|" + dr["Flood5"].ToString().Trim() + "|" + dr["EarthQuake5"].ToString().Trim() + "|" + dr["InsLength5"].ToString().Trim() + "|" + dr["SumInsuredType"].ToString().Trim() + "|" + dr["ClosingStatus"].ToString().Trim() + ";\r\n";			
            }
            cf.ExportToText(str,"wata"+ DateTime.Now.ToString());
        }
    }
}
