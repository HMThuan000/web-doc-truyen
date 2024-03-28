using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Windows.Input;

namespace DocTruyen.Add_Update_RemoveChapter_Command
{
    public class RemoveChapterCommand : Command
    {
        private readonly DataModel _db;
        private readonly string _id;

        public RemoveChapterCommand(DataModel db, string id)
        {
            _db = db;
            _id = id;
        }

        public void Execute()
        {
            _db.Get("EXEC removechapters " + _id);
        }
    }
}