using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyen.Add_Update_RemoveGenre_FactoryMethod
{
    public interface Genre
    {
        void AddGenre(string genre);
        void UpdateGenre(string genre, string id);
        void DeleteGenre(string id);
    }
}