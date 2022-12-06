using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;

namespace USoft.Common.Security
{
    public class Encryption
    {
        public Encryption()
        { }
        public static string passPhrase = "Pas5phr@se";           // can be any string
        public static string saltValue = "s@1tV@lue";             // can be any string
        public static string hashAlgorithm = "SHA1";              // can be "MD5" or "SHA1"
        public static int passwordIterations = 2;                 // can be any number
        public static string initVector = "@1B2c3D4e5F6g7H8";     // must be 16 bytes
        public static int keySize = 256;

        public static string Encrypt(string plainText, string passPhare, string saltValue, string hashAlgorithm,
                                     int passwordIterations, string initVector, int keySize)
        {
            string cipherText = "";
            if (plainText.Length <= 0)
            {
                return cipherText;
            }
            try
            {
                byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
                byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);
                byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);
                PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase,saltValueBytes,hashAlgorithm,passwordIterations);
                byte[] keyBytes = password.GetBytes(keySize / 8);
                RijndaelManaged symmetricKey = new RijndaelManaged();
                symmetricKey.Mode = CipherMode.CBC;
                ICryptoTransform encryptor = symmetricKey.CreateEncryptor(keyBytes,initVectorBytes);
                MemoryStream memoryStream = new MemoryStream();
                CryptoStream cryptoStream = new CryptoStream(memoryStream,encryptor,CryptoStreamMode.Write);
                cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
                cryptoStream.FlushFinalBlock();
                byte[] cipherTextBytes = memoryStream.ToArray();
                memoryStream.Close();
                cryptoStream.Close();
                cipherText = Convert.ToBase64String(cipherTextBytes);
            }
            catch
            {
                return cipherText;
            }
            return cipherText;
        }

        public static string Decrypt(string cipherText,string passPhrase,string saltValue,string hashAlgorithm,
                                     int passwordIterations,string initVector,int keySize)
        {
            string plainText = "";
            if (cipherText.Length <= 0)
            {
                return plainText;
            }
            try
            {
                byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
                byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);
                byte[] cipherTextBytes = Convert.FromBase64String(cipherText);
                PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase,saltValueBytes,hashAlgorithm,passwordIterations);
                byte[] keyBytes = password.GetBytes(keySize / 8);
                RijndaelManaged symmetricKey = new RijndaelManaged();
                symmetricKey.Mode = CipherMode.CBC;
                ICryptoTransform decryptor = symmetricKey.CreateDecryptor(keyBytes,initVectorBytes);
                MemoryStream memoryStream = new MemoryStream(cipherTextBytes);
                CryptoStream cryptoStream = new CryptoStream(memoryStream,decryptor,CryptoStreamMode.Read);
                byte[] plainTextBytes = new byte[cipherTextBytes.Length];
                int decryptedByteCount = cryptoStream.Read(plainTextBytes,0,plainTextBytes.Length);
                memoryStream.Close();
                cryptoStream.Close();
                plainText = Encoding.UTF8.GetString(plainTextBytes,0,decryptedByteCount);

            }
            catch
            {
                return plainText;
            }
            return plainText;
        }
    }
}
