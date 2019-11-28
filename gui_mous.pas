Unit GUI_Mous;

Interface

Uses Objects,
     GUI_Base;

Type TMouse = Object( TObject )
        Public
           XCoord : Word;
           YCoord : Word;
           LeftButton  : Boolean;
           RightButton : Boolean;

           Constructor Init;
           Destructor  Done; Virtual;

           Procedure Show;
           Procedure Hide;

           Procedure Refresh;
           Procedure SetPosition( x,y:Integer );

           Function OverObject( Obj:PVisualObject ) : Boolean;
           Function ClickObject( Obj:PVisualObject ) : Boolean;
     End;

Var Mouse : TMouse;

Implementation

Constructor TMouse.Init;
Var MouseInstalled : Boolean;
Begin
     asm
        xor  ax,ax
        int  33h
        mov  MouseInstalled,al
     end;
     if NOT( Inherited Init ) or NOT( MouseInstalled ) then Fail;
End;

Destructor TMouse.Done;
Begin
End;

Procedure TMouse.Show; Assembler;
Asm
   mov  ax,1
   int  33h
End;

Procedure TMouse.Hide; Assembler;
Asm
   mov  ax,2
   int  33h
End;

Procedure TMouse.Refresh;
Var TempX     : Word;
    TempY     : Word;
    TempLeft  : Boolean;
    TempRight : Boolean;
Begin
     TempLeft:=FALSE;
     TempRight:=FALSE;
     asm
        mov  ax,3
        int  33h
        mov  TempX,cx
        mov  TempY,dx
        mov  dx,bx
        and  dx,01b
        je   @_Test_Right_Button
        mov  TempLeft,TRUE
       @_Test_Right_Button:
        and  bx,10b
        je   @_END
        mov  TempRight,TRUE
       @_END:
     end;
     XCoord:=TempX;
     YCoord:=TempY;
     LeftButton:=TempLeft;
     RightButton:=TempRight;
End;

Procedure TMouse.SetPosition( x,y:Integer );
Begin
     asm
        mov  ax,4
        mov  cx,x
        mov  dx,y
        int  33h
     end;
     XCoord:=x;
     YCoord:=y;
End;

Function TMouse.OverObject( Obj:PVisualObject ) : Boolean;
Var x1     : Integer;
    y1     : Integer;
    x2     : Integer;
    y2     : Integer;
    Result : Boolean;
Begin
     if Obj^.Active then begin
        with Obj^ do begin
           GetRealCoords( x1,y1 );
           x2:=x1+GetWidth;
           y2:=y1+GetHeight;
        end;
        Refresh;
        Result:=(
                 ( XCoord>x1 ) AND
                 ( XCoord<x2 ) AND
                 ( YCoord>y1 ) AND
                 ( YCoord<y2 )
                );
     end else Result:=FALSE;
     OverObject:=Result;
End;

Function TMouse.ClickObject( Obj:PVisualObject ) : Boolean;
Var Result : Boolean;
Begin
     Result:=OverObject( Obj ) AND LeftButton;
     ClickObject:=Result;
End;


End.