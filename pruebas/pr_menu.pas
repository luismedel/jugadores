Program PRueba;

Uses Crt, GUI_Mous, GUI_Gfx, GUI_Menu;

Var Menu  : PMenu;
    Item1 : PMenuItem;
    Item2 : PMenuItem;
    Item3 : PMenuItem;

Begin
     New( Menu );
     New( Item1 );
     New( Item2 );
     New( Item3 );

     with Item1^ do begin
        Init( Menu,Item2,NIL );
        Caption:='Press me!';
        SetWidth( TextWidth(Caption) );
        SetHeight( TextHeight(Caption) );
     end;
     with Item2^ do begin
        Init( Menu,Item3,NIL );
        Caption:='-';
        SetWidth( TextWidth(Caption) );
        SetHeight( TextHeight(Caption) );
     end;
     with Item3^ do begin
        Init( Menu,NIL,NIL );
        Caption:='hola :)';
        SetWidth( TextWidth(Caption) );
        SetHeight( TextHeight(Caption) );
     end;
     Menu^.Init( NIL,NIL,Item1 );

     Mouse.Init;
     Mouse.Show;

     repeat Mouse.Refresh until Mouse.LeftButton;
     Menu^.SetLeft( Mouse.XCoord );
     Menu^.SetTop( Mouse.YCoord );

     Menu^.DrawAll;

     repeat
        Menu^.Test;
     until Mouse.RightButton;

     Item3^.Done;
     Item2^.Done;
     Item1^.Done;
     Menu^.Done;

     Dispose( Item3 );
     Dispose( Item2 );
     Dispose( Item1 );
     Dispose( Menu );
End.