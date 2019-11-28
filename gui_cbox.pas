Unit GUI_CBox;

Interface

Uses GUI_Base, GUI_Capt, GUI_Font, GUI_Gfx, GUI_Mous;

Const DefaultChkBoxWidth     : Integer = 75;
      DefaultChkBoxHeight    : Integer = 25;
      DefaultChkBoxCaption   : String  = 'New CheckBox';
      DefaultChkBoxFace      : TColor  = clLightGray;
      DefaultChkBoxLight     : TColor  = clWhite;
      DefaultChkBoxShadow    : TColor  = clDarkGray;
      DefaultChkBoxFontColor : TColor  = clBlack;

Type PcheckBox = ^TCheckBox;
     TCheckBox = Object( TVisualObject )
        Public
           Caption : TCaption;
           Font    : TFont;
           Checked : Boolean;

           Constructor Init( Parent,Next,Child : PVisualObject );
           Destructor Done; Virtual;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;
     End;

Implementation

Constructor TCheckBox.Init( Parent,Next,Child : PVisualObject );
Begin
     if NOT( Inherited Init( Parent,Next,Child ) ) then Fail else begin
        Caption:=DefaultChkBoxCaption;
        SetWidth( TextWidth( DefaultChkBoxCaption ) );
        SetHeight( 10 );
        Checked:=FALSE;
        with Font do begin
           FontFace:='Not supported :)';
           Color:=DefaultChkBoxFontColor;
        end;
     end;
End;

Destructor TCheckBox.Done;
Begin
End;

Procedure TCheckBox.Test;
Begin
     if Mouse.ClickObject( @Self ) then begin
        repeat Mouse.Refresh until NOT( Mouse.LeftButton ) AND NOT( Mouse.RightButton );
        Checked:=NOT( Checked );
        DrawAll;
     end;
End;

Procedure TCheckBox.Draw;
Type TPic = Array [0..9,0..9] of TColor;
Const Box_Unchecked : TPic =
( (clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite) );

      Box_Checked : TPic =
( (clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray, clDarkGray),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clBlack,    clWhite,    clWhite,    clWhite,    clWhite,    clBlack,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clBlack,    clBlack,    clWhite,    clWhite,    clBlack,    clBlack,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clBlack,    clBlack,    clBlack,    clBlack,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clWhite,    clBlack,    clBlack,    clWhite,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clWhite,    clBlack,    clBlack,    clBlack,    clBlack,    clWhite,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clBlack,    clBlack,    clWhite,    clWhite,    clBlack,    clBlack,    clWhite,    clWhite),
  (clDarkGray, clWhite,    clBlack,    clWhite,    clWhite,    clWhite,    clWhite,    clBlack,    clWhite,    clWhite),
  (clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite,    clWhite) );

Var i : Byte;
    j : Byte;
    Pic : ^TPic;

    x1 : Integer;
    y1 : Integer;
    x2 : Integer;
    y2 : Integer;
Begin
     Mouse.Hide;

     if NOT( ParentObject=NIL ) then begin
        x1:=ParentObject^.GetLeft+GetLeft;
        y1:=ParentObject^.GetTop+GetTop;
     end else begin
        x1:=GetLeft;
        y1:=GetTop;
     end;
     x2:=x1+GetWidth;
     y2:=y1+GetHeight;
     if Checked then Pic:=@Box_Checked else Pic:=@Box_Unchecked;
     for i:=0 to 9 do
         for j:=0 to 9 do PutPixel( x1+i,y1+j,Pic^[i,j] );
     OutTextXY( x1 + 10 + BorderSize,
                y1 + 2,
                Caption, Font.Color );

     Mouse.Show;
End;

End.