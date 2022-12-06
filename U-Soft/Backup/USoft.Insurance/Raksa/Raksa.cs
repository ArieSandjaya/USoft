using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using USoft.Common.Shared;
using USoft.Common.CommonFunction;

namespace USoft.Insurance.Raksa
{
    public class Raksa
    {
        public Raksa()
        { }
        public DataSet GetRaksa(int Branch, DateTime DateFrom, DateTime DateTo)
        {
            CommonFunction cf = new CommonFunction();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@BranchId", Branch));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DateStart",cf.DateNormalize(DateFrom)));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DateEnd", cf.DateNormalize(DateTo)));
            return sqlHandler.ExecuteAsDataSet("INSURANCE_RAKSA", ParameterCollection);
        }
        public void ConvertRaksa(DataSet ds)
        {
            CommonFunction cf = new CommonFunction();
            string str;
            str = "";
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                str = str + dr["NoContract"].ToString().Trim() + ";" + dr["Cabang"].ToString().Trim() + ";" + 
                      dr["Cabang2"].ToString().Trim() + ";"+ dr["NamaTertanggung"].ToString().Trim() +";"+ 
                      dr["vehicle_name"].ToString().Trim() + ";" + dr["vehicleEngineNo"].ToString().Trim() + ";" + 
                      dr["VehicleChasisNo"].ToString().Trim() + ";" + dr["VehicleYear"].ToString().Trim() + ";" + 
                      dr["VehicleColor"].ToString().Trim() + ";" + dr["NoPolisi"].ToString().Trim() + ";" + 
                      dr["PeriodeAwal"].ToString().Trim() + ";" + dr["PeriodeAkhir"].ToString().Trim() + ";" + 
                      dr["JenisPeranggungan"].ToString().Trim() + ";" + dr["Currency"].ToString().Trim() + ";" + 
                      cf.RemoveZeroToEmpty(dr["SumInsured"].ToString().Trim()) + ";" + cf.RemoveZeroToEmpty(dr["rate"].ToString().Trim()) + ";" +
                      cf.RemoveZeroToEmpty(dr["resiko"].ToString().Trim()) + ";" + cf.RemoveZeroToEmpty(dr["premi"].ToString().Trim()) + ";" + 
                      dr["accesories"].ToString().Trim() + ";" + dr["CmoName"].ToString().Trim()+ "\r\n";
            }
            cf.ExportToText(str,"Raksa"+ DateTime.Now.ToString());
        }
    }
}
