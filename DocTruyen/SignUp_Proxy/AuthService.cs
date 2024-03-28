using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyen.SignUp_Proxy
{
    public class AuthService : IAuthService
    {
        private DataModel db;

        public AuthService()
        {
            db = DataModel.Instance;
        }

        public void SignUp(string username, string password, string email)
        {
            db.Get("EXEC signupacc '" + username + "','" + password + "', '" + email + "' ;");
        }
    }
}