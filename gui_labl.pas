Unit GUI_Labl;

Interface

Uses GUI_Base, GUI_Gfx, GUI_Font, GUI_Capt, GUI_Mous;

Type PLabel = ^TLabel;
     TLabel = Object( TVisualObject )
        Public
           Caption : TCaption;
           Font    : TFont;

           Constructor Init( Parent, Next, Child : PVisualObject );
           Destructor  Done; Virtual;

           Procedure Draw; Virtual;
     end;


Implementation

Constructor TLabel.Init( Parent, Next, Child : PVisualObject );
Begin
     if NOT( Inherited Init( Parent,Next,Child ) ) then Fail else begin
        Caption:='';
        with Font do begin
           FontFace:='Not supported :)';
           Color:=clBlack;
        end;
        SetWidth( 0 );
        SetHeight( TextHeight('H') );
     end;
End;

Destructor  TLabel.Done;
Begin
End;

Procedure TLabel.Draw;
Var x : Integer;
    y : Integer;
Begin
     Mouse.Hide;

     GetRealCoords( x,y );
     OutTextXY( x,y,Caption,Font.Color );

     Mouse.Show;
End;

End.