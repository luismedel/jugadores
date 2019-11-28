Unit GUI_Base;

Interface

Uses Objects;

Type PVisualObject = ^TVisualObject;
     { ------------------------------------------------------ TVisualObject }
     TVisualObject = Object( TObject )

        Public { Public declarations }

           Name : String;

           ParentObject : PVisualObject;
           ChildObjects : PVisualObject;
           NextObject   : PVisualObject;

           Active : Boolean;

           Constructor Init( Parent, Next, Child : PVisualOBject );
           Destructor  Done; Virtual;

           Procedure GetRealCoords( Var x,y : Integer );
           Function  GetLeft : Integer;
           Function  GetTop : Integer;
           Procedure SetLeft( NewLeft:Integer );
           Procedure SetTop( NewTop:Integer );

           Function  GetWidth : Integer;
           Function  GetHeight : Integer;
           Procedure SetWidth( NewWidth:Integer );
           Procedure SetHeight( NewHeight:Integer );

           Procedure Test; Virtual;

           Procedure Draw; Virtual;
           Procedure DrawAll;

        Private { Private declarations }

           Left   : Integer;
           Top    : Integer;
           Width  : Integer;
           Height : Integer;
     End;{ -------------------------------------------------- TVisualObject }

Implementation

Procedure AddChildObjects( Parent:PVisualObject; Var ChildList:PVisualObject );
Var Temp : PVisualObject;
Begin
     if NOT( ChildList=NIL ) then begin
        Parent^.ChildObjects:=ChildList;
        Temp:=Parent^.ChildObjects;
        while NOT( Temp=NIL ) do begin
           Temp^.ParentObject:=Parent;
           Temp:=Temp^.NextObject;
        end;
     end else Parent^.ChildObjects:=NIL;
End;

Constructor TVisualObject.Init( Parent, Next, Child : PVisualObject );
Begin
     if NOT( Inherited Init ) then Fail else begin
        Active:=TRUE;
        Left:=0;
        Top:=0;
        Width:=0;
        Height:=0;
        ParentObject:=Parent;
        AddChildObjects( @Self,Child );
        NextObject:=Next;
     end;
End;

Destructor TVisualObject.Done;
Var TempA : PVisualObject;
    TempB : PVisualObject;
Begin
     TempA:=ChildObjects;
     while NOT( TempA=NIL ) do begin
        TempB:=TempA^.NextObject;
        TempA^.Done;
        TempA:=TempB;
     end;
End;

Procedure TVisualObject.GetRealCoords( Var x,y : Integer );
Var TempX : Integer;
    TempY : Integer;
Begin
     TempX:=GetLeft;
     TempY:=GetTop;
     if ( ParentOBject=NIL ) then begin
        x:=0;
        y:=0;
     end else ParentOBject^.GetRealCoords( x,y );
     x:=x+TempX;
     y:=y+TempY;
End;

Function TVisualObject.GetLeft : Integer;
Begin
     GetLeft:=Left;
End;

Function  TVisualObject.GetTop : Integer;
Begin
     GetTop:=Top;
End;

Procedure TVisualObject.SetLeft( NewLeft:Integer );
Begin
     Left:=NewLeft;
End;

Procedure TVisualObject.SetTop( NewTop:Integer );
Begin
     Top:=NewTop;
End;

Function TVisualObject.GetWidth : Integer;
Begin
     GetWidth:=Width;
End;

Function TVisualObject.GetHeight : Integer;
Begin
     GetHeight:=Height;
End;

Procedure TVisualObject.SetWidth( NewWidth:Integer );
Begin
     Width:=NewWidth;
End;

Procedure TVisualObject.SetHeight( NewHeight:Integer );
Begin
     Height:=NewHeight;
End;

Procedure TVisualObject.Test;
Begin
End;

Procedure TVisualObject.Draw;
Begin
End;

Procedure TVisualObject.DrawAll;
Var Temp : PVisualObject;
Begin
     Draw;
     Temp:=ChildObjects;
     if NOT( Temp=NIL ) then begin
        repeat
           Temp^.DrawAll;
           Temp:=Temp^.NextObject;
        until Temp=NIL;
     end;
End;

End.