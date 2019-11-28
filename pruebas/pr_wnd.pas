Program Prueba;

Uses Crt, GUI_Gfx, GUI_Mous, GUI_Wnd;

Var Wnd : Twindow;

Begin
     Mouse.Init;
     Mouse.Show;

     with Wnd do begin
        Init( NIL,NIL );
        WndType:=wtHorizontal;
        Color:=clRed;
        Caption:='Hola...';
        SetLeft( 100 );
        SetTop( 40 );
        DrawAll;
        Test;
        ReadKey;
        Done;
     end;

     Mouse.Hide;
     Mouse.Done;

     CloseGraph;
End.