Program Jugadores;

Uses Crt,
     GUI_Mous, GUI_Gen,  GUI_Gfx,  GUI_Base,
     GUI_Btns,  GUI_Text, GUI_CBox, GUI_Img,
     GUI_Capt,  GUI_Wnd,  GUI_Labl, GUI_Font,
     GUI_Panl, GUI_Menu;

Const Error : Boolean = FALSE;

Var { Ventana con la barra de botones ************************************* }
    wndBarraBotones                : PWindow;
{       btnArchivo                  : TButton;
          mnuArchivo               : TMenu;
             mitAbrir              : TMenuItem;
             mitGuardar            : TMenuItem;
             mitGuardarComo        : TMenuItem;
             mitSeparadorArchivo1  : TMenuItem;
             mitSalir              : TMenuItem;}
       { FIN de la barra de botones *************************************** }

Procedure ActivaMenu( Sender : PVisualObject ); Far;
Begin
{     if Sender=@btnArchivo then mnuArchivo.DrawAll;}
End;

Procedure BarraMenus_Inicio;
Const AnchoBotones = 75;
      AltoBotones  = 20;
Begin
{    with btnArchivo do begin
       Init( @wndBarraBotones,NIL,NIL );
       Caption:='Archivo';
       Action:=ActivaMenu;
       SetWidth( AnchoBotones );
       SetHeight( AltoBotones );
       SetLeft( BorderSize );
       SetTop( DefaultWndTitleBarSize+BorderSize );
    end;}
    { Opciones del menu }
{    with mitAbrir do begin
       Init( @mnuArchivo,@mitGuardar,NIL );
       Caption:='Abrir...';
    end;
    with mitGuardar do begin
       Init( @mnuArchivo,@mitGuardarComo,NIL );
       Caption:='Guardar...';
    end;
    with mitGuardarComo do begin
       Init( @mnuArchivo,@mitSeparadorArchivo1,NIL );
       Caption:='Guardar como...';
    end;
    with mitSeparadorArchivo1 do begin
       Init( @mnuArchivo,@mitSalir,NIL );
       Caption:='-';
    end;
    with mitSalir do begin
       Init( @mnuArchivo,NIL,NIL );
       Caption:='Salir...';
    end;
    mnuArchivo.Init( NIL,NIL,@mitAbrir );}

    New( wndBarraBotones );
    with wndBarraBotones^ do begin
       if Init( NIL,NIL ) then begin
          Caption:='Barra de botones';
          SetLeft( 0 );
          SetTop( 0 );
          SetWidth( (AnchoBotones*3)+(BorderSize*2) );
          SetHeight( AltoBotones+(BorderSize*2)+DefaultWndTitleBarSize );
       end else Error:=TRUE;
    end;
End;

Procedure BarraMenus_Fin;
Begin
End;

Begin
     Mouse.Init;
     Mouse.Show;

     ReadKey;

     wndBarraBotones^.Draw;

{     repeat
        wndBarraBotones.Test;
     until Mouse.RightButton;}

     repeat Mouse.Refresh until Mouse.RightButton;

     Mouse.Hide;
     Mouse.Done;

     CloseGraph;

     WriteLn( Error );
End.