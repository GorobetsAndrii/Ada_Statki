with Ada.Text_IO, GameUnit,Game;
use Ada.Text_IO, GameUnit,Game;

procedure Main is
   panel : gameRecord;
   choice : who := player;
   state : Boolean := False;
begin
   display(panel);
   while True loop

      state := shot(panel,choice);
      Put (ASCII.ESC & "[2J");
      display(panel);


      if state = False and choice = player then
         choice := computer;
      elsif state = False and choice = computer then
         choice := player;
      end if;

      if checkWin(panel,computer) then
         Put_Line("Computer win");
         exit;
      elsif checkWin(panel,player) then
         Put_Line("Player win");
         exit;
      end if;
   end loop;
end Main;
