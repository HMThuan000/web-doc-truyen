using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DocTruyen.LoginCheck_Strategy
{
    public interface LoginCheckStrategy
    {
        ActionResult Redirect();
    }
}