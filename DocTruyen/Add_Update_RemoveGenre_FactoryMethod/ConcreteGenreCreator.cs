using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DocTruyen.Add_Update_RemoveGenre_FactoryMethod
{
    public class ConcreteGenreCreator : GenreCreator
    {
        public override Genre CreateGenreManager()
        {
            return new GenreManager();
        }
    }
}