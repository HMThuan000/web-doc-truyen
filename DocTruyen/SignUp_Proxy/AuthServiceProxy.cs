using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DocTruyen.SignUp_Proxy
{
    public class AuthServiceProxy : IAuthService
    {
        private IAuthService authService;

        public AuthServiceProxy()
        {
            authService = new AuthService();
        }

        public void SignUp(string username, string password, string email)
        {
            try
            {
                authService.SignUp(username, password, email);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}