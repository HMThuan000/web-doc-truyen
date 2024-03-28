using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using DocTruyen.LoginCheck_Strategy;
using DocTruyen.Models;
using DocTruyen.SignUp_Proxy;

namespace DocTruyen.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("select * from Truyen inner join TacGia on Truyen.IdTacGia = TacGia.IdTacGia");
            return View();
        }

        public ActionResult FindComic(string comicname)
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("EXEC findcomic N'"+comicname+"'");
            return View();
        }

        public ActionResult ComicDetail(string id) 
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("exec findcomicbyid " + id);
            ViewBag.listChuong = db.Get("exec showcomiclistofchapter " + id);
            return View();
        }


        public ActionResult ReadComic(int id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("exec readcomic " + id);
            Session["CurrentChapterID"] = ViewBag.list[0];
            return View();
        }


        public ActionResult LoginPage()
        {
            return View();
        }

        [HttpPost]
        public ActionResult LoginCheck(string username, string password)
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("EXEC checklogin '" + username + "','" + password + "'");

            if (ViewBag.list != null && ViewBag.list.Count > 0)
            {
                var role = ViewBag.list[0][4];
                LoginCheckContext loginContext = new LoginCheckContext();
                Session["taikhoan"] = ViewBag.list[0];

                return loginContext.ExecuteStrategy(role);
            }

            ViewBag.ErrorMessage = "Invalid username or password";
            return RedirectToAction("LoginPage", "Home");
        }


        public ActionResult Logout()
        {
            // Xóa tất cả các thông tin lưu trữ trong session
            Session.Clear();

            // Chuyển hướng đến trang đăng nhập (hoặc trang chính)
            return RedirectToAction("Index", "Home");
        }

        public ActionResult SignUpPage()
        {
            return View();
        }


        public ActionResult SignUpCheck(string username, string password, string email)
        {
            IAuthService authService = new AuthServiceProxy();

            try
            {
                authService.SignUp(username, password, email);
                return RedirectToAction("LogInPage", "Home");
            }
            catch (Exception ex)
            {
                ViewBag.UsernameErrorMessage = null;
                ViewBag.EmailErrorMessage = null;

                if (ex.Message.Contains("Tên người dùng đã tồn tại!"))
                {
                    ViewBag.UsernameErrorMessage = ex.Message;
                }
                else if (ex.Message.Contains("Địa chỉ email đã được sử dụng để đăng ký!"))
                {
                    ViewBag.EmailErrorMessage = ex.Message;
                }

                // Return SignUpPage view in case of exception
                return View("SignUpPage");
            }
        }

        public ActionResult GenrePage()
        {
            DataModel db = DataModel.Instance;
            ViewBag.listGenre = db.Get("select * from theloai");
            return View();
        }

        public ActionResult ResultGenrePage(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.listGenre = db.Get("exec showgenrelistofcomic " + id);
            ViewBag.list = db.Get("select * from theloai");
            return View();
        }

        public ActionResult ProfilePage()
        {
            return View();
        }
    }
}