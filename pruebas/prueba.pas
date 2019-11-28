Program Pruba;

Uses Crt,
     GUI_CBox, GUI_Gfx;

Var l : TCheckBox;

Begin
     with l do begin
        Init( NIL,NIL,NIL );
        Checked:=TRUE;
        Font.Color:=clRed;
        Draw;
        Done;
     end;
     ReadKey;

     CloseGraph;
End.