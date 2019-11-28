Unit GUI_Wnd;

Interface

Uses GUI_Base, GUI_Gfx, GUI_Font, GUI_Capt, GUI_Mous;

Const DefaultWndFace           = clLightGray;
      DefaultWndLight          = clWhite;
      DefaultWndShadow         = clDarkGray;
      DefaultWndTitlebar       = clBlue;
      DefaultWndTitlebarLight  = clLightBlue;
      DefaultWndTitlebarShadow = clBlack;
      DefaultWndTitlebarSize   = 15;
      DefaultWndWidth          = 320;
      DefaultWndHeight         = 200;

Type PWindow = ^TWindow;
     TWindow = Object( TVisualObject )
        Public
           Caption : TCaption;
           Color   : TColor;
           Font    : TFont;

           Constructor Init( Next,Child:PVisualObject );
           Destructor  Done; Virtual;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;

           Procedure RestoreBG;
     End;

Implementation

Constructor TWindow.Init( Next,Child:PVisualObject );
Begin
     if NOT( Inherited Init( NIL,Next,Child ) ) then Fail else begin
        SetWidth( DefaultWndWidth );
        setHeight( DefaultWndHeight );
        Caption:='';
        Color:=DefaultWndTitlebar;
        Font.FontFace:='Not supported :)';
        Font.Color:=clWhite;
     end;
End;

Destructor  TWindow.Done;
Begin
End;

Procedure TWindow.Test;
Var TempLeft   : Integer;
    TempTop    : Integer;
    TempWidth  : Integer;
    TempHeight : Integer;

    TempMouseX : Integer;
    TempMouseY : Integer;

    IncX       : Integer;
    IncY       : Integer;

    TempChild : PVisualObject;

    Procedure XORScreen( x1,y1,x2,y2:Integer );
    Var i    : Integer;
        Temp : TColor;
    Begin
         Mouse.Hide;
         for i:=x1 to x2 do begin
            Temp:=GetPixel( i,y1 );
            Temp:=Temp XOR 15;
            PutPixel( i,y1,Temp );

            Temp:=GetPixel( i,y2 );
            Temp:=Temp XOR 15;
            PutPixel( i,y2,Temp );
         end;

         for i:=y1 to y2 do begin
            Temp:=GetPixel( x1,i );
            Temp:=Temp XOR 15;
            PutPixel( x1,i,Temp );

            Temp:=GetPixel( x2,i );
            Temp:=Temp XOR 15;
            PutPixel( x2,i,Temp );
         end;
         Mouse.Show;
    End;

Begin
     if Mouse.OverObject( @self ) then begin

        TempHeight:=GetHeight;
        SetHeight( DefaultWndTitlebarSize );

        if Mouse.ClickObject( @Self ) then begin

           TempMouseX:=Mouse.Xcoord;
           TempMouseY:=Mouse.YCoord;

           GetRealCoords( IncX,IncY );
           IncX:=TempMouseX-IncX;
           IncY:=TempMouseY-IncY;

           TempLeft:=GetLeft;
           TempTop:=GetTop;
           TempWidth:=GetWidth;


           SetHeight( TempHeight );
           RestoreBG;
           SetHeight( DefaultWndTitlebarSize );

           XORScreen( TempLeft, TempTop, TempLeft+TempWidth, TempTop+TempHeight );
           repeat
              Mouse.Refresh;
              if NOT(TempMouseX=Mouse.XCoord) AND NOT(TempMouseY=Mouse.YCoord) then begin
                 XORScreen( TempLeft, TempTop, TempLeft+TempWidth, TempTop+TempHeight );

                 TempMouseX:=Mouse.XCoord;
                 TempMouseY:=Mouse.YCoord;
                 TempLeft:=TempMouseX-IncX;
                 if (TempLeft+TempWidth)>=MaxX then TempLeft:=MaxX-TempWidth-1 else
                    if TempLeft<0 then TempLeft:=0;
                 TempTop:=TempMouseY-IncY;
                 if (TempTop+TempHeight)>=MaxY then TempTop:=MaxY-TempHeight-1 else
                    if TempTop<0 then TempTop:=0;

                 XORScreen( TempLeft, TempTop, TempLeft+TempWidth, TempTop+TempHeight );
              end;
           until NOT( Mouse.LeftButton );
           XORScreen( TempLeft, TempTop, TempLeft+TempWidth, TempTop+TempHeight );

           SetLeft( TempLeft );
           SetTop( TempTop );
           SetHeight( TempHeight );
           DrawAll;
        end else SetHeight( TempHeight );

        TempChild:=ChildObjects;
        while NOT( TempChild=NIL ) do begin
           TempChild^.Test;
           TempChild:=TempChild^.NextObject;
        end;
     end;
End;

Procedure TWindow.Draw;
Var x1 : Integer;
    y1 : Integer;
    x2 : Integer;
    y2 : Integer;

Begin
     Mouse.Hide;

     GetRealCoords( x1,y1 );
     x2:=x1+GetWidth;
     y2:=y1+GetHeight;

     { Window face }
     Rectangle( x1,y1,x2,y2,DefaultWndFace );
     Line( x1,y1+DefaultWndTitlebarSize+1,
           x2,y1+DefaultWndTitlebarSize+1,
           DefaultWndLight );
     Line( x1,y1+DefaultWndTitlebarSize+1,
           x1,y2,
           DefaultWndLight );
     Line( x1,y2,
           x2,y2,
           DefaultWndShadow );
     Line( x2,y1+DefaultWndTitlebarSize+1,
           x2,y2,
           DefaultWndShadow );

     { Tltlebar }
     Rectangle( x1,
                y1,
                x2,
                y1+DefaultWndTitlebarSize,Color );
     Line( x1,y1,x2,y1,DefaultWndTitlebarLight );
     Line( x1,y1,x1,y1+DefaultWndTitlebarsize,DefaultWndTitlebarLight );
     Line( x2,y1,x2,y1+DefaultWndTitlebarsize,DefaultWndTitlebarShadow );
     Line( x1,y1+DefaultWndTitlebarSize,x2,y1+DefaultWndTitlebarsize,DefaultWndTitlebarShadow );

     { Caption }
     OutTextXY( x1+BorderSize,
                y1+BorderSize,
                Caption,
                Font.Color );

     Mouse.Show;
End;

Procedure TWindow.RestoreBG;
Begin
     Mouse.Hide;
     Rectangle( GetLeft,GetTop,GetLeft+GetWidth,GetTop+GetHeight,clBackground );
     Mouse.Show;
End;

End.