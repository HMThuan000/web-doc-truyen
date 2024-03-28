using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyen.Add_Update_RemoveGenre_FactoryMethod
{
    public abstract class GenreCreator
    {
        public abstract Genre CreateGenreManager();
    }
}