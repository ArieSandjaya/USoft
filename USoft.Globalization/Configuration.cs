using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace USoft.Globalization
{
    public class Configuration : ConfigurationSection
    {
        public Configuration()
        {}
        [ConfigurationProperty("StoredProcedure")]
        public GetSections StoredProcedure
        {
            get { return (GetSections)this["StoredProcedure"]; }
        }
    }
    public class GetSections : ConfigurationSection
    {
        public GetSections()
        { }
        [ConfigurationProperty("StoredProcedure")]
        public GetElement StoredProcedure
        {
            get { return (GetElement)this["StoredProcedure"]; }
        }
    }
    public class GetElement : ConfigurationElement
    {
        public GetElement()
        { }
        public GetElement(string _SpName, string _TextField, string _ValueField)
        {
            SpName = _SpName;
            TextField = _TextField;
            ValueField = _ValueField;
        }
        [ConfigurationProperty("SpName", IsRequired = true)]
        public string SpName
        { 
            get
            { return (string)this["SpName"]; }
            set
            { this["SpName"] = value; }
        }
        [ConfigurationProperty("TextField", IsRequired = true)]
        public string TextField
        { 
            get 
            { return (string)this["TextField"]; }
            set
            { this["TextField"] = value; }
        }
        [ConfigurationProperty("ValueField", IsRequired = true)]
        public string ValueField
        { 
            get 
            { return (string)this["ValueField"]; }
            set
            { this["ValueField"] = value; }

        }
    }
}
