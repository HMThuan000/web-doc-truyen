using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DocTruyen.Models;

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
            ViewBag.listChuong = db.Get("exec listchapter_mainpage " + id);
            return View();
        }

        public ActionResult ReadComic()
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("select * from chuongtruyen");
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

                if (role == "Admin")
                {
                    Session["taikhoan"] = ViewBag.list[0];
                    return RedirectToAction("QuanLyTruyen", "QuanLy");
                }
                else if (role == "User")
                {
                    Session["taikhoan"] = ViewBag.list[0];
                    return RedirectToAction("Index", "Home");
                }
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
            DataModel db = DataModel.Instance;
            try
            {
                db.Get("EXEC signupacc '" + username + "','" + password + "', '" + email + "' ;");
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
                return View("SignUpPage");
            }
        }
    }
}