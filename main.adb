with Ada.Text_IO, GameUnit,Game;
use Ada.Text_IO, GameUnit,Game;

procedure Main is
   panel : gameRecord;
   choice : who := player;
   state : Boolean := False;
   i : Integer := 0;

   task type monitor is
      entry displayBoard;
      entry printWinner(str : String);
   end monitor;

   task body monitor is
   begin
      loop
         select
            accept displayBoard  do
               display(panel);
            end displayBoard;
         or
            accept printWinner (str : in String) do
               Put_Line(str);
            end printWinner;
         or
              terminate;
         end select;
      end loop;
   end monitor;

   mon : monitor;

   task play;
   task body play is
   begin
      display(panel);
      while i < 5 loop

         state := shot(panel,choice);
         Put (ASCII.ESC & "[2J");
         --display(panel);
         mon.displayBoard;

         if state = False and choice = player then
            choice := computer;
         elsif state = False and choice = computer then
            choice := player;
         end if;

         if checkWin(panel,computer) then
            --Put_Line("Computer win");
            mon.printWinner("Computer win");
            exit;
         elsif checkWin(panel,player) then
            --Put_Line("Player win");
            mon.printWinner("Player win");
            exit;
         end if;
         i := i + 1;
      end loop;
   end play;

begin
   null;
end Main;
