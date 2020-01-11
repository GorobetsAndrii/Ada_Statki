with Ada.Text_IO,Ada.Integer_Text_IO;
use Ada.Text_IO;

package body Game is
   procedure display(monitor : gameRecord) is
   begin
      Put_Line("Player:");
      print(monitor.playerBoard);
      Put_Line("");

      Put_Line("Computer:");
      print(monitor.PCBoard2Print);
      Put_Line("");
   end display;

   function char2num(c : Character) return Integer is
   begin
      if Character'Pos(c) > 90 then
         return Character'Pos(c) - 32 - 65;
      else
         return Character'Pos(c) - 65;
      end if;
   end char2num;

   function shot(monitor :in out gameRecord; shooter : who) return Boolean is
      i : Integer := 0;
      j : Integer := 0;
      c : Character;
   begin
      case shooter is
         when computer =>
               generateXY(i,j);
               if monitor.playerBoard.board(i,j) = '#' then
                  monitor.playerBoard.board(i,j) := 'X';
                  monitor.playerBoard2Print.board(i,j) := 'X';
                  monitor.computerBoard.prevStepI := i;
                  monitor.computerBoard.prevStepJ := j;
                  monitor.computerBoard.hit := True;
                  shipExplosion(monitor,i,j,player);
                  return True;
               else
                  monitor.playerBoard.board(i,j) := '+';
                  monitor.playerBoard2Print.board(i,j) := '+';
                  monitor.computerBoard.hit := False;
                  return False;
               end if;
         when player =>
            while True loop
               Put("Row: ");
               Get(c);
               i := char2num(c);
               if i < 0 or i > 9 then
                  Put_Line("Wrong data entry ");
               else
                  exit;
               end if;
            end loop;

            while True loop
               Put("Column: ");
               Get(c);
               j := Character'Pos(c) - 48;
               if j < 0 or j > 9 then
                  Put_Line("Wrong data entry");
               else
                  exit;
               end if;
            end loop;

            if monitor.computerBoard.board(i,j) = '#' then
               monitor.computerBoard.board(i,j) := 'X';
               monitor.PCBoard2Print.board(i,j) := 'X';
               monitor.playerBoard.prevStepI := i;
               monitor.playerBoard.prevStepJ := j;
               monitor.playerBoard.hit := True;
               shipExplosion(monitor,i,j,computer);
               return True;
            else
               monitor.computerBoard.board(i,j) := '+';
               monitor.PCBoard2Print.board(i,j) := '+';
               monitor.playerBoard.hit := False;
               return False;
            end if;
         when others =>
            return True;
      end case;
   end shot;

   function checkWin(monitor : in gameRecord; winner : who) return Boolean is
   begin
      case winner is
         when computer =>
            for I in monitor.playerBoard.board'Range(1) loop
               for J in monitor.playerBoard.board'Range(2) loop
                  if monitor.playerBoard.board(i,j) = '#' then
                     return False;
                  end if;
               end loop;
            end loop;
            return True;
         when player =>
            for I in monitor.computerBoard.board'Range(1) loop
               for J in monitor.computerBoard.board'Range(2) loop
                  if monitor.computerBoard.board(i,j) = '#' then
                     return False;
                  end if;
               end loop;
            end loop;
            return True;
      end case;

   end checkWin;

   procedure shipExplosion(monitor : in out gameRecord; i,j : in out Integer; ship : who)is
      counter : Integer := 0;
   begin
      case ship is
         when player =>
            if isEnd(monitor.playerBoard,monitor.playerBoard2Print,i,j) then
               moveX(monitor.playerBoard,i,j);
               set(monitor.playerBoard,monitor.playerBoard2Print,i,j);
            end if;

         when computer =>
            if isEnd(monitor.computerBoard,monitor.playerBoard2Print,i,j) then
               moveX(monitor.computerBoard,i,j);
               set(monitor.computerBoard,monitor.PCBoard2Print,i,j);
            end if;
      end case;
   end shipExplosion;

   function isEnd(b,bp : BoardInterface; i,j : Integer) return Boolean is
   begin
         if i + 1 < 10 then
            if b.board(i+1,j) = '#' then
               return False;
            end if;
         end if;

         if i - 1 >= 0 then
            if b.board(i-1,j) = '#' then
               return False;
            end if;
         end if;

         if j + 1 < 10 then
            if b.board(i,j+1) = '#' then
               return False;
            end if;
         end if;

         if j - 1 >= 0 then
            if b.board(i,j-1) = '#' then
               return False;
            end if;
         end if;

         return True;
   end isEnd;

   procedure setX(b,bp : in out BoardInterface; i,j : in out Integer) is
      state : Boolean := True;
   begin
      if i-1 >= 0 and j-1 >= 0 then
         if b.board(i-1,j-1) /= 'X' then
            b.board(i-1,j-1) := '+';
            bp.board(i-1,j-1) := '+';
         end if;
      end if;

      if i-1 >= 0 then
         if b.board(i-1,j) /= 'X' then
            b.board(i-1,j) := '+';
            bp.board(i-1,j) := '+';
         end if;
      end if;

      if i-1 >= 0 and j+1 < 10 then
         if b.board(i-1,j+1) /= 'X' then
            b.board(i-1,j+1) := '+';
            bp.board(i-1,j+1) := '+';
         end if;
      end if;

      if j-1 >= 0 then
         if b.board(i,j-1) /= 'X' then
            b.board(i,j-1) := '+';
            bp.board(i,j-1) := '+';
         end if;
      end if;

      if j+1 < 10 then
         if b.board(i,j+1) /= 'X' then
            b.board(i,j+1) := '+';
            bp.board(i,j+1) := '+';
         end if;
      end if;

      if i+1 < 10 and j-1 >= 0 then
         if b.board(i+1,j-1) /= 'X' then
            b.board(i+1,j-1) := '+';
            bp.board(i+1,j-1) := '+';
         end if;
      end if;

      if i+1 < 10 then
         if b.board(i+1,j) /= 'X' then
            b.board(i+1,j) := '+';
            bp.board(i+1,j) := '+';
         end if;
      end if;

      if i+1 < 10 and j+1 >= 0 then
         if b.board(i+1,j+1) /= 'X' then
            b.board(i+1,j+1) := '+';
            bp.board(i+1,j+1) := '+';
         end if;
      end if;
   end setX;

   procedure set(b,bp : in out BoardInterface; i,j : in out Integer) is
   begin

      if i-1 >= 0 then
         if b.board(i-1,j) = 'X' then
            while i-1 >=0 and b.board(i,j) = 'X' loop
               setX(b,bp,i,j);
               i := i - 1;
            end loop;
            return;
         end if;
      end if;

      if i+1 < 10 then
         if b.board(i+1,j) = 'X' then
            while i+1 < 10 and b.board(i,j) = 'X' loop
               setX(b,bp,i,j);
               i := i + 1;
            end loop;
            return;
         end if;
      end if;

      if j-1 >=0 then
         if b.board(i,j-1) = 'X' then
            while j-1 >=0 and b.board(i,j) = 'X' loop
               setX(b,bp,i,j);
               j := j - 1;
            end loop;
            return;
         end if;
      end if;

      if j+1 < 10 then
         if b.board(i,j+1) = 'X' then
            while j+1 < 10 and b.board(i,j) = 'X' loop
               setX(b,bp,i,j);
               j := j + 1;
            end loop;
            return;
         end if;
      end if;

      setX(b,bp,i,j);
   end set;

   procedure moveX(b : in BoardInterface; i,j : in out Integer) is
   begin

      if i-1 >=0 then
         if b.board(i-1,j) = 'X' then
            while i-1 >=0 and b.board(i-1,j) = 'X' loop
               i := i-1;
               if i-1 < 0 then
                  exit;
               end if;
            end loop;
            return;
         end if;
      end if;

      if j-1 >= 0 then
         if b.board(i,j-1) = 'X' then
            while j-1 >= 0 and b.board(i,j-1) = 'X' loop
               j := j-1;
               if j-1 < 0 then
                  exit;
               end if;
            end loop;
            return;
         end if;
      end if;

   end moveX;

end Game;
