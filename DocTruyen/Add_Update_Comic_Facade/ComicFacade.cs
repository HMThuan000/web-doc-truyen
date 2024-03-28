using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DocTruyen.Add_Update_Comic_Facade
{
    public class ComicFacade
    {
        private readonly DataModel _dataModel;
        private readonly HttpContextBase _httpContext;

        public ComicFacade(Controller controller)
        {
            _dataModel = DataModel.Instance;
            _httpContext = controller.HttpContext;
        }

        public void AddComic(string tentruyen, string mota, HttpPostedFileBase hinhminhhoa, string matg)
        {
            try
            {
                if (hinhminhhoa != null && hinhminhhoa.ContentLength > 0)
                {
                    string filename = Path.GetFileName(hinhminhhoa.FileName);
                    string path = Path.Combine(_httpContext.Server.MapPath("~/img"), filename);
                    hinhminhhoa.SaveAs(path);
                    _dataModel.Get("EXEC addcomic N'" + tentruyen + "', N'" + mota + "' , '" + hinhminhhoa.FileName + "', " + matg + ";");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Đã xảy ra lỗi khi thêm truyện: " + ex.Message);
            }
        }

        public void UpdateComic(string tentruyen, string mota, HttpPostedFileBase hinhminhhoa, string matg, string id)
        {
            try
            {
                if (hinhminhhoa != null && hinhminhhoa.ContentLength > 0)
                {
                    string filename = Path.GetFileName(hinhminhhoa.FileName);
                    string path = Path.Combine(_httpContext.Server.MapPath("~/img"), filename);
                    hinhminhhoa.SaveAs(path);
                    _dataModel.Get("EXEC updatecomic N'" + tentruyen + "', N'" + mota + "' , '" + hinhminhhoa.FileName + "', " + matg + ", " + id + ";");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Đã xảy ra lỗi khi cập nhật truyện: " + ex.Message);
            }
        }
    }
}