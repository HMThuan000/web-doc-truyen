using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace DocTruyen.LoginCheck_Strategy
{
    public class UserLoginStrategy : LoginCheckStrategy
    {
        private readonly ActionResult _redirectResult;

        public UserLoginStrategy(ActionResult redirectResult)
        {
            _redirectResult = redirectResult;
        }

        public ActionResult Redirect()
        {
            return _redirectResult;
        }
    }
}