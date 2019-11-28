Program Jugadores;

Uses GUI_Gfx, GUI_Mous, GUI_Diag, Data, Barra, Vars, Forms, Crt;

Begin
     InitGraph;
     BarraMenus_Inicio;

     Mouse.Init;
     Mouse.Show;

     ShowMsg( 'Atencion','Version 0.09 Beta :)','Aceptar' );
     ShowMsg( 'Atencion','Las cr¡ticas son bienvenidas','Entendido' );

     clBackground:=clLightGray;

     pnlDesktop^.DrawAll;
     pnlBarraBotones^.DrawAll;

     repeat
        pnlBarraBotones^.Test;
     until Salir;

     BarraMenus_Fin;
     CloseGraph;

     WriteLn( 'El programa se encuentra a£n en su versi¢n beta' );
     WriteLn( 'y pretende llegar a ser algo interesante ( alg£n d¡a. :D )' );
     WriteLn;
     WriteLn( 'Pulse una tecla para finalizar...' );
     ReadKey;
End.