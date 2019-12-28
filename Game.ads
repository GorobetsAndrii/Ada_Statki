with GameUnit;
use GameUnit;

package Game is
   type who is (computer,player);
   type gameRecord is record
      playerBoard : BoardInterface := init;
      playerBoard2Print : BoardInterface := zeros;
      computerBoard : BoardInterface := init;
      PCBoard2Print : BoardInterface := zeros;
   end record;
   procedure display(monitor : gameRecord);
   function char2num(c : Character) return Integer;
   function shot(monitor : in out gameRecord; shooter : who) return Boolean;
   function checkWin(monitor : in gameRecord; winner : who) return Boolean;
   procedure shipExplosion(monitor : in out gameRecord; i,j : in out  Integer; ship : who);
   function isEnd(b,bp : BoardInterface; i,j : Integer) return Boolean;
   procedure setX(b,bp : in out BoardInterface; i,j : in out Integer);
   procedure set(b,bp : in out BoardInterface; i,j : in out Integer);
   procedure moveX(b : in BoardInterface; i,j : in out Integer);
end Game;
