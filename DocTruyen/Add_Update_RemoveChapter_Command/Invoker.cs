using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Windows.Input;

namespace DocTruyen.Add_Update_RemoveChapter_Command
{
    public class Invoker
    {
        private readonly List<Command> _commands = new List<Command>();

        public void AddCommand(Command command)
        {
            _commands.Add(command);
        }

        public void ExecuteCommands()
        {
            foreach (var command in _commands)
            {
                command.Execute();
            }
        }
    }
}