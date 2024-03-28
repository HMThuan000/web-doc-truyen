using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyen.SignUp_Proxy
{
    public interface IAuthService
    {
        void SignUp(string username, string password, string email);
    }
}