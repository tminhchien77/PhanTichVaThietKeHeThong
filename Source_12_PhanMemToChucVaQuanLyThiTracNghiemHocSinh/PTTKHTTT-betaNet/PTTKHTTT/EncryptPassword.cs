using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace PTTKHTTT
{
    class EncryptPassword
    {
        public static String myEncrypt(String s)
        {
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(s);
            byte[] hashData = new MD5CryptoServiceProvider().ComputeHash(temp);
            String hashPass = null;
            foreach(byte item in hashData)
            {
                hashPass += item;
            }
            return hashPass;
        }
    }
}
