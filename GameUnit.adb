with Ada.Text_IO, Ada.Numerics.discrete_Random;
use Ada.Text_IO;

package body GameUnit is

   procedure print(b : in BoardInterface) is
   begin
      Put_Line("  0 1 2 3 4 5 6 7 8 9");
      for I in b.board'Range(1) loop
         Put(Character'Val(I + 65) & " ");
         for J in b.board'Range(2) loop
            Put(b.board(I,J) & " ");
         end loop;
         Put_Line("");
      end loop;
   end print;

   function zeros return BoardInterface is
      b : BoardInterface;
   begin
      for I in b.board'Range(1) loop
         for J in b.board'Range(2) loop
            b.board(I,J) := 'o';
         end loop;
      end loop;
      return b;
   end zeros;

   procedure setShip(b : in out BoardInterface) is
   begin
      setFourDeck(b);
      setThreeDeck(b);
      setTwoDeck(b);
      setOneDeck(b);
   end setShip;

   procedure generateXY(i,j : in out Integer)is
      package Los_Liczby is new Ada.Numerics.Discrete_Random(Integer);
      use Los_Liczby;
      gen : Generator;
   begin
      Reset(gen);
      i := abs(Random(gen)) mod 9;
      j := abs(Random(gen)) mod 9;
   end generateXY;

   procedure setFourDeck(b : in out BoardInterface) is
      i : Integer := 0;
      j : Integer := 0;
   begin
      generateXY(i,j);
      if (j+3) < 10 then
         for X in 1..4 loop
            b.board(i,j) := '#';
            j := j+1;
         end loop;

      elsif (i+3) < 10 then
         for X in 1..4 loop
            b.board(i,j) := '#';
            i := i+1;
         end loop;

      elsif (i-3) >= 0 then
         for X in 1..4 loop
            b.board(i,j) := '#';
            i := i-1;
         end loop;

      else
         for X in 1..4 loop
            b.board(i,j) := '#';
            j := j-1;
         end loop;

      end if;

   end setFourDeck;

   procedure setThreeDeck(b : in out BoardInterface) is
      i : Integer := 0;
      j : Integer := 0;
      state : Boolean := False;
      Y : Integer := 0;
   begin
      while Y < 2 loop
         generateXY(i,j);
         state := False;

         if (j+2) < 10 then
            if checkShips(b,i,j,2,"right") = True then
               for X in 1..3 loop
                  b.board(i,j) := '#';
                  j := j+1;
               end loop;
               state := True;
            end if;
         elsif (i+2) < 10 then
            if checkShips(b,i,j,2,"down") = True then
               for X in 1..3 loop
                  b.board(i,j) := '#';
                  i := i+1;
               end loop;
               state := True;
            end if;
         elsif (i-2) >= 0 then
            if checkShips(b,i,j,2,"up") = True then
               for X in 1..3 loop
                  b.board(i,j) := '#';
                  i := i-1;
               end loop;
               state := True;
            end if;
         elsif checkShips(b,i,j,2,"left") then
            for X in 1..3 loop
               b.board(i,j) := '#';
               j := j-1;
            end loop;
            state := True;
         end if;

         if state then
            Y := Y + 1;
         end if;

      end loop;

   end setThreeDeck;

   procedure setTwoDeck(b : in out BoardInterface) is
      i : Integer := 0;
      j : Integer := 0;
      state : Boolean := False;
      Y : Integer := 0;
   begin
      while Y < 3 loop
         generateXY(i,j);
         state := False;

         if (j+1) < 10 then
            if checkShips(b,i,j,1,"right") = True then
               for X in 1..2 loop
                  b.board(i,j) := '#';
                  j := j+1;
               end loop;
               state := True;
            end if;
         elsif (i+1) < 10 then
            if checkShips(b,i,j,1,"down") = True then
               for X in 1..2 loop
                  b.board(i,j) := '#';
                  i := i+1;
               end loop;
               state := True;
            end if;
         elsif (i-1) >= 0 then
            if checkShips(b,i,j,1,"up") = True then
               for X in 1..2 loop
                  b.board(i,j) := '#';
                  i := i-1;
               end loop;
               state := True;
            end if;
         elsif checkShips(b,i,j,1,"left") then
            for X in 1..2 loop
               b.board(i,j) := '#';
               j := j-1;
            end loop;
            state := True;
         end if;

         if state then
            Y := Y + 1;
         end if;

      end loop;

   end setTwoDeck;

   procedure setOneDeck(b : in out BoardInterface) is
      i : Integer := 0;
      j : Integer := 0;
      state : Boolean := False;
      X : Integer := 0;
   begin
      while X < 4 loop
         generateXY(i,j);
         state := False;

         if checkCell(b,i,j) then
            b.board(i,j) := '#';
            state := True;
         end if;

         if state then
            X := X + 1;
         end if;

      end loop;

   end setOneDeck;

   function checkShips(b: in BoardInterface; i,j,num : in Integer; route : String) return Boolean is
      type r is (right,left,up,down);
   begin

      case r'Value(route) is
         when right =>
            for X in j..(num+j) loop
               if checkCell(b,i,X) = False then
                  return False;
               end if;
            end loop;
            return True;
         when left =>
            for X in j..(j-num) loop
               if checkCell(b,i,X) = False then
                  return False;
               end if;
            end loop;
            return True;
         when up =>
            for X in i..(i-num) loop
               if checkCell(b,X,j) = False then
                  return False;
               end if;
            end loop;
            return True;
         when down =>
            for X in i..(num+i) loop
               if checkCell(b,X,j) = False then
                  return False;
               end if;
            end loop;
            return True;
         when others =>
            return True;
      end case;
   end checkShips;

   function checkCell(b : in BoardInterface; i,j : in Integer) return Boolean is
   begin
      if b.board(i,j) = '#' then
         return False;
      end if;

      if i-1 >= 0 and j-1 >= 0 then
         if b.board(i-1,j-1) = '#' then
            return False;
         end if;
      end if;

      if i-1 >= 0 then
         if b.board(i-1,j) = '#' then
            return False;
         end if;
      end if;

      if i-1 >= 0 and j+1 < 10 then
         if b.board(i-1,j+1) = '#' then
            return False;
         end if;
      end if;

      if  j-1 >= 0 then
         if b.board(i,j-1) = '#' then
            return False;
         end if;
      end if;

      if j+1 < 10 then
         if b.board(i,j+1) = '#' then
            return False;
         end if;
      end if;

      if i+1 < 10 and j-1 >= 0 then
         if b.board(i+1,j-1) = '#' then
            return False;
         end if;
      end if;

      if i+1 < 10 then
         if b.board(i+1,j) = '#' then
            return False;
         end if;
      end if;

      if i+1 < 10 and j+1 < 10 then
         if b.board(i+1,j+1) = '#' then
            return False;
         end if;
      end if;

      return True;
   end checkCell;

   function init return BoardInterface is
      result : BoardInterface;
   begin
      result := zeros;
      setShip(result);
      result.prevStepI := -1;
      result.prevStepJ := -1;
      result.hit := False;
      return result;
   end init;

end GameUnit;








