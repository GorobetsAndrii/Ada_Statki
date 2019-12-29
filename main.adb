with Ada.Text_IO, GameUnit,Game;
use Ada.Text_IO, GameUnit,Game;

procedure Main is
   panel : gameRecord;
   choice : who := player;
   i : Integer := 0;
   state : Boolean := False;
begin
   display(panel);
   while i < 5 loop

      state := shot(panel,choice);
      display(panel);


      if state = False and choice = player then
         choice := computer;
      elsif state = False and choice = computer then
         choice := player;
      end if;

      i := i + 1;
   end loop;


end Main;
