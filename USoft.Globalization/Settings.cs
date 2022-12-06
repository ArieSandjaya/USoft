using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Web;
using System.Collections.Specialized;

namespace USoft.Globalization
{
    public class Settings
    {
        private static System.Configuration.Configuration Config;
        public Settings()
        {
            //Configuration config = 
            string str = System.Web.HttpContext.Current.Server.MapPath("~/Lookup.config");
            ExeConfigurationFileMap configMap = new ExeConfigurationFileMap();
            configMap.ExeConfigFilename = str;
            Config = ConfigurationManager.OpenMappedExeConfiguration(configMap, ConfigurationUserLevel.None);
            Configuration SectionConfiguration = (Configuration)Config.GetSection("Test");
        }
        //public string GetConfigration(string section)
        //{
        //    //return Config.AppSettings.Settings[section].Value;
        //}
    }
}
