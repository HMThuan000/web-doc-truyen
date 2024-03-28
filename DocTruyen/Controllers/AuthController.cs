using DocTruyen.LoginCheck_Strategy;
using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DocTruyen.Controllers
{
    public class AuthController : Controller
    {
        //private readonly LoginCheckContext _loginContext;
        //private readonly HttpContextBase _httpContext;

        //public AuthController(LoginCheckContext loginContext, HttpContextBase httpContext)
        //{
        //    _loginContext = loginContext;
        //    _httpContext = httpContext;
        //}

        //[HttpPost]
        //public ActionResult LoginCheck(string username, string password)
        //{
        //    DataModel db = DataModel.Instance;
        //    ViewBag.list = db.Get("EXEC checklogin '" + username + "','" + password + "'");

        //    if (ViewBag.list != null && ViewBag.list.Count > 0)
        //    {
        //        var role = ViewBag.list[0][4];
        //        LoginCheckStrategy loginStrategy;

        //        switch (role)
        //        {
        //            case "Admin":
        //                loginStrategy = new AdminLoginStrategy(_httpContext);
        //                break;
        //            case "User":
        //                loginStrategy = new UserLoginStrategy(_httpContext);
        //                break;
        //            default:
        //                throw new ArgumentException("Invalid role specified");
        //        }

        //        var loginContext = new LoginCheckContext(loginStrategy);
        //        return loginContext.ProcessLogin(username, password);
        //    }

        //    ViewBag.ErrorMessage = "Invalid username or password";
        //    return RedirectToAction("LoginPage", "Home");
        //}
    }
}