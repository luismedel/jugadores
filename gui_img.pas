Unit GUI_Img;

Interface

Uses GUI_Base, GUI_Gfx, GUI_Mous, GUI_Gen;

Const DefaultImgWidth  : Integer = 100;
      DefaultImgHeight : Integer = 100;
      DefaultImgColor  : TColor = clBlack;

Type PImage = ^TImage;
     TImage = Object( TVisualObject )
        Public
           Stretch : Boolean;
           Path    : String;

           Constructor Init( Parent,Next,Child:PVisualObject );
           Destructor  Done; Virtual;

           Procedure Load;

           Procedure Test; Virtual;

           Procedure Draw; Virtual;

        Private
           Buffer  : Pointer;
           BufferSize : Word;
     End;

Implementation

Constructor TImage.Init( Parent,Next,Child:PVisualObject );
Begin
     if NOT( Inherited Init( Parent,Next,Child ) ) then Fail else begin
        Stretch:=FALSE;
        Path:='';
        Buffer:=NIL;
        SetWidth( DefaultImgWidth );
        SetHeight( DefaultImgHeight );
     end;
End;

Destructor  TImage.Done;
Begin
     if (BufferSize>0) then begin
        FreeMem( Buffer,BufferSize );
        BufferSize:=0;
     end;
End;

Procedure TImage.Load;
Var f    : File;
    TempWidth  : Integer;
    TempHeight : Integer;
Begin
     if NOT( Path='' ) AND FileExists( Path ) then begin
        Assign( f,Path );
        Reset( f,1 );
        BlockRead( f,TempWidth,2 );
        BlockRead( f,TempHeight,2 );
        SetWidth( TempWidth );
        SetHeight( TempHeight );
        BufferSize:=( TempWidth*TempHeight );
        GetMem( Buffer,BufferSize );
        BlockRead( f,Buffer,BufferSize );
        Close( f );
     end;
End;

Procedure TImage.Test;
Var TempChild : PVisualObject;
Begin
     if Mouse.ClickObject( @self ) then begin
        TempChild:=ChildObjects;
        while NOT( TempChild=NIL ) do begin
           TempChild^.Test;
           TempChild:=TempChild^.NextObject;
        end;
     end;
End;

Procedure TImage.Draw;
Var x1 : Integer;
    y1 : Integer;
    x2 : Integer;
    y2 : Integer;

    i : Integer;
    j : Integer;

    Img : Array [0..0,0..0] of TColor ABSOLUTE Buffer;

Begin
     Mouse.Hide;

     GetRealCoords( x1,y1 );
     x2:=x1+GetWidth;
     y2:=y1+GetHeight;

     if (BufferSize>0) then begin
       for i:=0 to GetWidth-1 do
          for j:=0 to GetHeight-1 do PutPixel( x1+i,y1+j,Img[i,j] );
     end else Rectangle( x1,y1,x2,y2,DefaultImgColor );

     Mouse.Show;
End;

End.