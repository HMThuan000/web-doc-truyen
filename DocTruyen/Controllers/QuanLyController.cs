using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using DocTruyen.Add_Update_Comic_Facade;
using DocTruyen.Add_Update_RemoveChapter_Command;
using DocTruyen.Add_Update_RemoveGenre_FactoryMethod;
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
            ViewBag.listChuong = db.Get("exec showcomiclistofchapter " + id);
            //ViewBag.listChuong = db.Get("exec listchapter_mainpage " + id);
            ViewBag.addchapter = db.Get("exec chapterinfo " + id);
            return View();
        }

        public ActionResult QuanLyChuongTruyen()
        {
            DataModel db = DataModel.Instance;
            ViewBag.list = db.Get("select * from ChuongTruyen left join Truyen on Truyen.IdTruyen = ChuongTruyen.IdTruyen order by idchuong desc");
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
        public ActionResult AddChapter(string cname, string read, string id)
        {
            DataModel db = DataModel.Instance;
            Invoker _commandInvoker = new Invoker();
            _commandInvoker.AddCommand(new AddChapterCommand(db, cname, read, id));
            _commandInvoker.ExecuteCommands();
            return RedirectToAction("QuanLyChuongTruyen", "QuanLy");
        }

        [HttpPost]
        public ActionResult UpdateChapter(string cname, string read, string id)
        {
            DataModel db = DataModel.Instance;
            Invoker _commandInvoker = new Invoker();
            _commandInvoker.AddCommand(new UpdateChapterCommand(db, cname, read, id));
            _commandInvoker.ExecuteCommands();
            return RedirectToAction("QuanLyChuongTruyen", "QuanLy");
        }

        public ActionResult RemoveChapter(string id)
        {
            DataModel db = DataModel.Instance;
            Invoker _commandInvoker = new Invoker();
            _commandInvoker.AddCommand(new RemoveChapterCommand(db, id));
            _commandInvoker.ExecuteCommands();
            return RedirectToAction("QuanLyChuongTruyen", "QuanLy");
        }


        [HttpPost]
        public ActionResult AddComic(string tentruyen, string mota, HttpPostedFileBase hinhminhhoa, string matg)
        {
            try
            {
                var comicFacade = new ComicFacade(this);
                comicFacade.AddComic(tentruyen, mota, hinhminhhoa, matg);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
            }
            return RedirectToAction("QuanLyTruyen", "QuanLy");
        }

        [HttpPost]
        public ActionResult UpdateComic(string tentruyen, string mota, HttpPostedFileBase hinhminhhoa, string matg, string id)
        {
            try
            {
                var comicFacade = new ComicFacade(this);
                comicFacade.UpdateComic(tentruyen, mota, hinhminhhoa, matg, id);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
            }
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

        public ActionResult QuanLyNguoiDung()
        {
            DataModel db = DataModel.Instance;
            ViewBag.listUser = db.Get("select * from nguoidung");
            return View();
        }

        public ActionResult RemoveUser(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.listUser = db.Get("exec removeuser " + id);
            return RedirectToAction("QuanLyNguoiDung", "QuanLy");
        }

        public ActionResult QuanLyTheLoai()
        {
            DataModel db = DataModel.Instance;
            ViewBag.listGenre = db.Get("select * from theloai");
            return View();
        }

        public ActionResult QuanLyTheLoaiChiTiet(string id)
        {
            DataModel db = DataModel.Instance;
            ViewBag.listGenre = db.Get("exec quanlytheloaichitiet " + id);
            return View();
        }


        [HttpPost]
        public ActionResult AddGenre(string genre)
        {
            GenreCreator _genreManagerCreator;
            _genreManagerCreator = new ConcreteGenreCreator();

            Genre genreManager = _genreManagerCreator.CreateGenreManager();
            genreManager.AddGenre(genre);
            return RedirectToAction("QuanLyTheLoai", "QuanLy");
        }

        [HttpPost]
        public ActionResult UpdateGenre(string genre, string id)
        {
            GenreCreator _genreManagerCreator;
            _genreManagerCreator = new ConcreteGenreCreator();

            Genre genreManager = _genreManagerCreator.CreateGenreManager();
            genreManager.UpdateGenre(genre, id);
            return RedirectToAction("QuanLyTheLoai", "QuanLy");
        }

        public ActionResult DeleteGenre(string id)
        {
            GenreCreator _genreManagerCreator;
            _genreManagerCreator = new ConcreteGenreCreator();

            Genre genreManager = _genreManagerCreator.CreateGenreManager();
            genreManager.DeleteGenre(id);
            return RedirectToAction("QuanLyTheLoai", "QuanLy");
        }
    }
}