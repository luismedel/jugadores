Unit GUI_Text;

Interface

Uses GUI_Base, GUI_Font, GUI_Mous, GUI_Gfx;

Const DefaultTxtBoxWidth     : Integer = 100;
      DefaultTxtBoxHeight    : Integer = 12;
      DefaultTxtBoxText      : String  = 'New TextBox';
      DefaultTxtBoxColor     : TColor  = clWhite;
      DefaultTxtBoxLight     : TColor  = clWhite;
      DefaultTxtBoxShadow    : TColor  = clDarkGray;
      DefaultTxtBoxTextColor : TColor  = clBlack;

Type PTextBox = ^TTextBox;
     TTextBox = Object( TVisualObject )
        Public
           Text : String;
           Font : TFont;

           MaxLength : Byte;

           IsNumber : Boolean;

           Constructor Init( Parent, Next, Child : PVisualObject );
           Destructor  Done; Virtual;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;
     End;

Implementation

Uses Crt;

Const CursorChar = '_';

Constructor TTextBox.Init( Parent, Next, Child : PVisualObject );
Begin
     if NOT( Inherited Init( Parent, Next, Child ) ) then Fail else begin
        SetWidth( DefaultTxtBoxWidth );
        SetHeight( DefaultTxtBoxHeight );
        Text:=DefaultTxtBoxText;
        MaxLength:=255;
        IsNumber:=FALSE;
        with Font do begin
           FontFace:='Not supported :)';
           Color:=DefaultTxtBoxTextColor;
        end;
     end;
End;

Destructor TTextBox.Done;
Begin
End;

Function GetEnd( S:String; Width:Integer ) : String;
Var i      : Byte;
    Pos    : Byte;
    Result : String;
Begin
     Pos:=(Width DIV 8) - 3;
     Result:='';
     for i:=Length(S)-Pos to Length(S) do Result:=Result+S[i];
     GetEnd:=Result;
End;

Procedure TTextBox.Test;
Var Exit : Boolean;
    Ch   : Char;
    Temp : String;
    i    : Byte;
Begin
     if Mouse.ClickObject( @Self ) then begin
        Text:=Text+CursorChar;
        DrawAll;
        Dec( Text[0] );
        Exit:=FALSE;
        while KeyPressed do ReadKey;
        Temp:=Text;
        i:=Length( Temp );
        repeat
           if NOT( Mouse.OverObject(@Self) ) AND
                    ( (Mouse.LeftButton) or (Mouse.RightButton) ) then Exit:=TRUE
           else if NOT( Exit ) then begin
              if KeyPressed then begin
                 Ch:=ReadKey;
                 if Ch=#8 then begin
                    if NOT( i=0 ) then begin
                       Dec( Temp[0] );
                       Dec( i );
                    end;
                 end else begin
                    if ( Ch=#9 ) or
                       ( Ch=#13 ) then Exit:=TRUE
                    else if (i<MaxLength) then begin
                       if IsNumber then begin
                          if Ch in ['0'..'9','-'] then begin
                             Temp:=Temp+Ch;
                             Inc( i );
                          end;
                       end else begin
                          Temp:=Temp+Ch;
                          Inc( i );
                       end;
                    end;
                 end;
                 Text:=Temp+CursorChar;
                 DrawAll;
                 Dec( Text[0] );
              end;
           end;
        until Exit;
        DrawAll;
     end;
End;

Procedure TTextBox.Draw;
Var x1 : Integer;
    y1 : Integer;
    x2 : Integer;
    y2 : Integer;

    TempStr : String;
Begin
     Mouse.Hide;

     GetRealCoords( x1,y1 );
     x2:=x1+GetWidth;
     y2:=y1+GetHeight;

     Rectangle( x1,y1,x2,y2,DefaultTxtBoxColor );
     Line( x1,y1,x2,y1,DefaultTxtBoxShadow );
     Line( x1,y1,x1,y2,DefaultTxtBoxShadow );
     Line( x1,y2,x2,y2,DefaultTxtBoxLight );
     Line( x2,y1,x2,y2,DefaultTxtBoxLight );

     if ( BorderSize+TextWidth( Text )+BorderSize ) < (x2-x1) then TempStr:=Text
     else TempStr:=GetEnd( Text,(x2-x1) );
     OutTextXY( x1 + BorderSize,
                y1 + ( ((y2-y1) SHR 1) - (TextHeight(Text) SHR 1 ) ),
                TempStr, Font.Color );

     Mouse.Show;
End;

End.