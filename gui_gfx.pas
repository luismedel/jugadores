Unit GUI_Gfx;

Interface

Uses Graph;

Type TColor = Word;

{ --------------------- }
{ Definicion de colores }
{ --------------------- }
Const clBlack        = Graph.Black;
      clBlue         = Graph.Blue;
      clGreen        = Graph.Green;
      clCyan         = Graph.Cyan;
      clRed          = Graph.Red;
      clMagenta      = Graph.Magenta;
      clBrown        = Graph.Brown;
      clLightGray    = Graph.LightGray;
      clDarkGray     = Graph.DarkGray;
      clLightBlue    = Graph.LightBlue;
      clLightGreen   = Graph.LightGreen;
      clLightCyan    = Graph.LightCyan;
      clLightRed     = Graph.LightRed;
      clLightMagenta = Graph.LightMagenta;
      clYellow       = Graph.Yellow;
      clWhite        = Graph.White;

      clBackground   : TColor = Graph.Black;

      BorderSize     = 3;

      MaxX = 640;
      MaxY = 480;

{ ---------------------------------------- }
{ Definicion de funciones y procedimientos }
{ ---------------------------------------- }
Function InitGraph : Boolean;

Const CloseGraph : Procedure                             = Graph.CloseGraph;
      PutPixel   : Procedure ( x,y:Integer; Color:Word ) = Graph.PutPixel;
      GetPixel   : Function (x,y:Integer ) : TColor      = Graph.GetPixel;

      TextWidth  : Function ( Str:String ) : Word = Graph.TextWidth;
      TextHeight : Function ( Str:String ) : Word = Graph.TextHeight;

Procedure SetColor ( Color:TColor );

Procedure Line      ( x1,y1,x2,y2:Integer; Color:TColor );
Procedure Rectangle ( x1,y1,x2,y2:Integer; Color:TColor );
Procedure OutTextXY ( x,y:Integer; TextString:String; Color:TColor );

Implementation

Var tmpColor : TColor;

Function InitGraph : Boolean;
Var Gd     : Integer;
    Gm     : Integer;
    Result : Boolean;
Begin
     Gd:=Detect;
     Gm:=$12; { Modo 640x480x16 }
     Graph.InitGraph( Gd,Gm,'' );
     Result:=( GraphResult=grOk );
     if result then begin
        SetFillStyle( EmptyFill, clBlack );
        FloodFill( 0,0,clLightGray );
        SetColor( clBlack );
     end;
     InitGraph:=Result;
End;

Procedure SetColor( Color:TColor );
Begin
     tmpColor:=Color;
     Graph.SetColor( Color );
End;

Procedure Line( x1,y1,x2,y2:Integer; Color:TColor );
Begin
     if NOT( Color=tmpColor ) then SetColor( Color );
     Graph.Line( x1,y1,x2,y2 );
End;

Procedure Rectangle( x1,y1,x2,y2:Integer; Color:TColor );
Var i : Integer;
Begin
     if NOT( Color=tmpColor ) then SetColor( Color );
     for i:=0 to y2-y1 do Graph.Line( x1,y1+i,x2,y1+i );
End;

Procedure OutTextXY( x,y:Integer; TextString:String; Color:TColor );
Begin
     if NOT( Color=tmpColor ) then SetColor( Color );
     Graph.OutTextXY( x,y,TextString );
End;

End.