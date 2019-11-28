Unit GUI_Menu;

Interface

Uses GUI_Gfx,GUI_Base, GUI_Btns, GUI_Font, GUI_Capt, GUI_Panl, GUI_Mous;

Const DefaultMenuItemColor       : TColor = clBlack;
      DefaultMenuItemActiveColor : TColor = clRed;

Type PMenuItem = ^TMenuItem;
     TMenuItem = Object( TVisualOBject )
        Public
           Caption : TCaption;
           Action  : TAction;
           Font    : TFont;

           Constructor Init( Parent,Next,Child:PVisualObject );
           Destructor  Done; Virtual;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;
     End;

     PMenu = ^TMenu;
     TMenu = Object( TPanel )
        Public
           Constructor Init( Parent,Next,Child:PVisualObject );
           Destructor  Done; Virtual;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;
     End;

Implementation

Constructor TMenuItem.Init( Parent,Next,Child:PVisualObject );
Begin
     if NOT( Inherited Init(Parent,Next,Child) ) then Fail else begin
        Action:=NoAction;
        Caption:='';
        with Font do begin
           FontFace:='Not supported :)';
           Color:=DefaultMenuItemColor;
        end;
     end;
End;

Destructor TMenuItem.Done;
Begin
End;

Procedure TMenuItem.Test;
Var Color : TColor;
Begin
     if Mouse.OverObject( @Self ) then begin
        Color:=Font.Color;
        Font.Color:=DefaultMenuItemActiveColor;
        DrawAll;
        while Mouse.OverObject( @Self ) do begin
           if Mouse.LeftButton then Action( @Self );
        end;
        Font.Color:=Color;
        DrawAll;
     end;
End;

Procedure TMenuItem.Draw;
Var x : Integer;
    y : Integer;

    TempW : Integer;
Begin
     Mouse.Hide;
     GetRealCoords( x,y );
     y:=y + (GetHeight SHR 1)-(TextHeight(Caption) SHR 1);
     if Caption='-' then begin
     TempW:=ParentObject^.GetWidth-BorderSize;
        Line( x+BorderSize,y,x+TempW,y,DefaultBtnShadow );
        Line( x+BorderSize,y+1,x+TempW,y+1,DefaultBtnLight );
     end else begin
        if Active then OutTextXY( x+BorderSize,y,Caption,Font.Color )
        else OutTextXY( x+BorderSize,y,Caption,clDarkGray );
     end;
     Mouse.Show;
End;

Constructor TMenu.Init( Parent,Next,Child:PVisualObject );
Begin
     if NOT( Inherited Init(Parent,Next,Child) ) then Fail;
End;

Destructor TMenu.Done;
Begin
End;

Procedure TMenu.Test;
Var Child : PVisualObject;
Begin
     repeat Mouse.Refresh until NOT( Mouse.LeftButton ) AND NOT( Mouse.RightButton );
     while Mouse.OverObject( @Self ) do begin
        Child:=ChildOBjects;
        while NOT( Child=NIL ) do begin
           Child^.Test;
           Child:=Child^.NextObject;
        end;
     end;
     RestoreBG;
     if NOT( ParentObject=NIL ) then ParentObject^.DrawAll;
End;

Procedure TMenu.Draw;
Var Child     : PVisualOBject;
    MaxWidth  : Integer;
    MaxHeight : Integer;
    TempW     : Integer;
Begin
     MaxWidth:=0;
     MaxHeight:=0;

     Child:=ChildObjects;
     while NOT( Child=NIL ) do begin
        TempW:=Child^.GetWidth+(BorderSize SHL 1);
        if TempW>MaxWidth then MaxWidth:=TempW;
        Child^.SetTop( MaxHeight+BorderSize );
        MaxHeight:=MaxHeight+Child^.GetHeight+BorderSize;
        Child:=Child^.NextObject;
     end;

     SetWidth( MaxWidth );
     SetHeight( MaxHeight );

     Inherited Draw;
End;

End.