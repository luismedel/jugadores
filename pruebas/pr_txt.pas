Program Prueba;

Uses Crt, GUI_Gfx, GUI_Btns, GUI_CBox, GUI_Mous;

Var ea : TButton;
    Luis : TCheckBox;

    feo : TButton;

    var a, b :integer;

Procedure Pr; Far;
Begin
     Sound(1000);
     Delay(1000);
     NoSound;
End;

Begin
     Mouse.Init;
     Mouse.Show;

     with Feo do begin
        Init( NIL,NIL,NIL );
        SetLeft( 0 );
        SetTop( 0 );
        SetWidth( 639 );
        SetHeight( 479 );
        Draw;
        Done;
     end;

     with Luis do begin
        Init( @ea,NIL,NIL );
        Active:=TRUE;
        Font.Color:=clWhite;
        Caption:='Click me! :)';
        SetWidth( 10+BorderSize+TextWidth(Caption) );
        SetLeft( 10 );
        SetTop( 10 );
     end;

     with ea do begin
        Init( NIL,NIL,@Luis );
        Active:=TRUE;
        Pressed:=FALSE;
        Caption:='hola :)';
        Action:=Pr;
        SetLeft( 150 );
        SetTop( 100 );
        SetWidth( 300 );
        SetHeight( 200 );
        DrawAll;
     end;

     repeat
        if Mouse.ClickObject( @Luis ) then begin
           Luis.Checked:=NOT( Luis.Checked );
           Luis.Draw;
           repeat Mouse.Refresh until NOT( Mouse.LeftButton ) and NOT( Mouse.RightButton );
        end;
        ea.Test;
     until Mouse.RightButton and Mouse.LeftButton;

     Mouse.Hide;
     Mouse.Done;
     CloseGraph;

     Luis.GetRealCoords( a,b );
     writeln( a );
     writeln( b );

     ea.Done;
     Luis.Done;
End.