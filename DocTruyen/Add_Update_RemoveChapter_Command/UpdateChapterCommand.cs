using DocTruyen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Windows.Input;

namespace DocTruyen.Add_Update_RemoveChapter_Command
{
    public class UpdateChapterCommand : Command
    {
        private readonly DataModel _db;
        private readonly string _cname;
        private readonly string _read;
        private readonly string _id;

        public UpdateChapterCommand(DataModel db, string cname, string read, string id)
        {
            _db = db;
            _cname = cname;
            _read = read;
            _id = id;
        }

        public void Execute()
        {
            _db.Get("exec updatechapter N'" + _cname + "', N'" + _read + "', N'" + _id + "' ;");
        }
    }
}