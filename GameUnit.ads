package GameUnit is
   type gameBoard is array (0..9, 0..9) of Character;
   type BoardInterface is record
      board : gameBoard;
      prevStepI : Integer;
      prevStepJ : Integer;
      hit : Boolean;
   end record;
   function zeros return BoardInterface;
   procedure print(b : in BoardInterface);
   procedure setShip(b : in out BoardInterface);
   procedure generateXY(i,j : in out Integer);
   procedure setFourDeck(b : in out BoardInterface);
   procedure setThreeDeck(b : in out BoardInterface);
   procedure setTwoDeck(b : in out BoardInterface);
   procedure setOneDeck(b : in out BoardInterface);
   function checkShips(b: in BoardInterface; i,j,num : in Integer; route : String) return Boolean;
   function checkCell(b : in BoardInterface; i,j : in Integer) return Boolean;
   function init return BoardInterface;
end GameUnit;
