using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DocTruyen.Add_Update_RemoveGenre_FactoryMethod
{
    public class GenreManager : Genre
    {
        public void AddGenre(string genre)
        {
            DataModel db = DataModel.Instance;
            db.Get("exec addgenre N'" + genre + "'; ");
        }

        public void UpdateGenre(string genre, string id)
        {
            DataModel db = DataModel.Instance;
            db.Get("exec updategenre N'" + genre + "', " + id + "; ");
        }

        public void DeleteGenre(string id)
        {
            DataModel db = DataModel.Instance;
            db.Get("exec removegenre " + id);
        }
    }
}