Program prueba;

Uses Crt, GUI_Gfx, GUI_Diag, GUI_Mous;

Var Temp : String;

Begin
     Mouse.Init;
     Mouse.Show;

     Temp:='';

{     InputQuery( 'Escribe algo mierdoso','Aceptar','Cancelar',Temp );}
   Confirmation( 'hola','holaaaaaa','Si','No' );

     Mouse.Hide;
     Mouse.Done;

     CloseGraph;
End.