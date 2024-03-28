using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DocTruyen.Models;

namespace DocTruyen.Controllers
{
    public class QuanLyController : Controller
    {
        // GET: QuanLy
        public ActionResult QuanLyTruyen()
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("Exec getcomicinfo");
            ViewBag.listTG = db.Get("select * from tacgia");
            return View();
        }

        public ActionResult QuanLyTruyenChiTiet(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("exec QuanLyTruyenChiTiet " + id);
            ViewBag.listTG = db.Get("select * from tacgia");
            ViewBag.listChuong = db.Get("exec showchapter " + id);
            //ViewBag.listChuong = db.Get("exec listchapter_mainpage " + id);
            ViewBag.addchapter = db.Get("exec getcomicinfo " + id);
            return View();
        }

        public ActionResult QuanLyChuongTruyen()
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("select * from ChuongTruyen left join Truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen order by ngaydangchuong desc");
            return View();
        }

        public ActionResult QuanLyChuongTruyenChiTiet(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("exec chapterinfo " + id);
            return View();
        }

        public ActionResult AddChapterPage(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.tentruyen = db.Get("exec findcomicbyid " +id);
            return View();
        }

        [HttpPost]
        public ActionResult AddComic(string tentruyen,
                                     string mota,
                                     HttpPostedFileBase hinhminhhoa,
                                     string matg)
        {
            try
            {
                if (hinhminhhoa != null && hinhminhhoa.ContentLength > 0)
                {
                    string filename = Path.GetFileName(hinhminhhoa.FileName);
                    string path = Path.Combine(Server.MapPath("~/img"), filename);
                    hinhminhhoa.SaveAs(path);
                    DataModel db = DataModel.Instance;
                    ViewBag.list = db.Get("EXEC addcomic N'" + tentruyen + "', N'" + mota + "' , '" + hinhminhhoa.FileName + "', " + matg + ";");
                }
            } catch(Exception ex) { ViewBag.Error = "Đã xảy ra lỗi: " + ex.Message; }
            return RedirectToAction("QuanLyTruyen", "QuanLy");
        }

        [HttpPost]
        public ActionResult UpdateComic(string tentruyen,
                                        string mota,
                                        HttpPostedFileBase hinhminhhoa,
                                        string matg,
                                        string id)
        {
            try
            {
                if (hinhminhhoa != null && hinhminhhoa.ContentLength > 0)
                {
                    string filename = Path.GetFileName(hinhminhhoa.FileName);
                    string path = Path.Combine(Server.MapPath("~/img"), filename);
                    hinhminhhoa.SaveAs(path);
                    DataModel db = DataModel.Instance;
                    ViewBag.list = db.Get("EXEC updatecomic N'" + tentruyen + "', N'" + mota + "' , '" + hinhminhhoa.FileName + "', " + matg + ", " +id+ ";");
                }
            }
            catch (Exception ex) { ViewBag.Error = "Đã xảy ra lỗi: " + ex.Message; }
            return RedirectToAction("QuanLyTruyen", "QuanLy");
        }

        public ActionResult RemoveComic(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("EXEC DeleteComicById " + id);
            return RedirectToAction("QuanLyTruyen", "QuanLy");
        }

        public ActionResult Index()
        {
            if (Session["taikhoan"] == null)
            {
                return RedirectToAction("LoginPage", "Home");
            }

            return View();
        }
    }
}