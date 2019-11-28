Unit GUI_Gen;

Interface

Function IntToStr( Int:Integer ) : String;
Function StrToInt( Str:String ) : Integer;
Function FileExists( Path:String ) : Boolean;

Implementation

Function IntToStr( Int:Integer ) : String;
Var Result : String;
Begin
     Str( Int,Result );
     IntToStr:=Result;
End;

Function StrToInt( Str:String ) : Integer;
Var Result : Integer;
    Error  : Integer;
Begin
     Val( Str,Result,Error );
     if NOT( Error=0 ) then Result:=0;
     StrToInt:=Result;
End;

Function FileExists( Path:String ) : Boolean;
Var f      : File;
    Result : Boolean;
Begin
  {$I-}
     Assign( f,Path );
     Reset( f,1 );
     Close( f );
     Result:=(IOResult=0);
     FileExists:=Result;
  {$I+}
End;

End.