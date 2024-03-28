using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace DocTruyen.LoginCheck_Strategy
{
    public class LoginCheckContext
    {
        private readonly Dictionary<string, LoginCheckStrategy> _strategies;

        public LoginCheckContext()
        {
            _strategies = new Dictionary<string, LoginCheckStrategy>
            {
                { "Admin", new AdminLoginStrategy(new RedirectToRouteResult(new RouteValueDictionary(new { controller = "QuanLy", action = "QuanLyTruyen" }))) },
                { "User", new UserLoginStrategy(new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Home", action = "Index" }))) }
            };
        }

        public ActionResult ExecuteStrategy(string role)
        {
            if (_strategies.ContainsKey(role))
            {
                return _strategies[role].Redirect();
            }
            else
            {
                // Default behavior or error handling
                return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Home", action = "LoginPage" }));
            }
        }
    }
}