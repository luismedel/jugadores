Program Prueba;

Uses GUI_Gfx, GUI_Mous;

Const Mask : Array [0..(32*2)-1] of Byte =
         ( 0, 0, 0, 0, 0, 0, 0, 0,
           0, 0,
           0,
           0,
           0,
           0,
           0,
           0,
           11,
           12,
           13,
           14,
           15,
           16,
           17,
           18,
           19,
           10,
           11,
           12,
           13,
           14,
           15,
           16,

           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           128,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255,
           255 );

Var Se  : Word;
    Off : Word;

Begin
     Mouse.Init;

     Se:=Seg( Mask );
     Off:=Ofs( Mask );
     asm
        mov  ax,9
        mov  bx,0
        mov  cx,0
        mov  es,Se
        mov  dx,Off
        int  33h
     end;
 
     Mouse.Show;

     repeat Mouse.Refresh until Mouse.LeftButton;

     Mouse.Hide;
     Mouse.Done;

     CloseGraph;
End.