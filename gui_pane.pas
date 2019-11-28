Unit GUI_Wnd;

Interface

Uses GUI_Base, GUI_Gfx, GUI_Capt, GUI_Mous;

Const DefaultPanelFace   : TColor = clLightGray;
      DefaultPanelLight  : TColor = clWhite;
      DefaultPanelShadow : TColor = clDarkGray;

Type PPanel  = ^TPanel;
     TPanel = Object( TVisualObject )
        Public
           Constructor Init( Next,Child:PVisualObject );
           Destructor  Done; Virtual;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;
     End;

Implementation

Constructor TPanel.Init( Next,Child:PVisualObject );
Begin
     if NOT( Inherited Init( NIL,Next,Child ) ) then Fail;
End;

Destructor  TPanel.Done;
Begin
End;

Procedure TPanel.Test;
Var TempChild : PVisualObject;
Begin
     if Mouse.OverObject( @self ) then begin
        TempChild:=ChildObjects;
        while NOT( TempChild=NIL ) do begin
           TempChild^.Test;
           TempChild:=TempChild^.NextObject;
        end;
     end;
End;

Procedure TPanel.Draw;
Var x1 : Integer;
    y1 : Integer;
    x2 : Integer;
    y2 : Integer;

Begin
     Mouse.Hide;

     GetRealCoords( x1,y1 );
     x2:=x1+GetWidth;
     y2:=y1+GetHeight;

     Rectangle( x1,y1,x2,y2,DefaultPanelFace );
     Line( x1,y1,x2,y1,DefaultPanelLight );
     Line( x1,y1,x1,y2,DefaultPanelLight );
     Line( x1,y2,x2,y2,DefaultPanelShadow );
     Line( x2,y1,x2,y2,DefaultPanelShadow );

     Mouse.Show;
End;

End.