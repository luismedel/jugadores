Unit Barra;

Interface

Uses GUI_Mous, GUI_Gen,  GUI_Gfx,  GUI_Base,
     GUI_Btns, GUI_Text, GUI_CBox, GUI_Img,
     GUI_Capt, GUI_Wnd,  GUI_Labl, GUI_Font,
     GUI_Panl, GUI_Menu, GUI_Diag;

Const AnchoBotones = 75;
      AltoBotones  = 20;

Var { Panel que actua como fondo de escritorio **************************** }
    pnlDesktop                     : PPanel;
    { Ventana con la barra de botones ************************************* }
    pnlBarraBotones                : PPanel;
       btnArchivo                  : PButton;
          mnuArchivo               : PMenu;
             mitCrear              : PMenuItem;
             mitDestruir           : PMenuItem;
             mitSeparadorArchivo1  : PMenuItem;
             mitAbrir              : PMenuItem;
             mitGuardar            : PMenuItem;
             mitGuardarComo        : PMenuItem;
             mitSeparadorArchivo2  : PMenuItem;
             mitSalir              : PMenuItem;

       btnRegistro                 : PButton;
          mnuRegistro              : PMenu;
             mitNuevo              : PMenuItem;
             mitSeparadorRegistro1 : PMenuItem;
             mitMostrar            : PMenuItem;

       btnAyuda                    : PButton;
          mnuAyuda                 : PMenu;
             mitAcercaDe           : PMenuItem;
       { FIN de la barra de botones *************************************** }

Procedure BarraMenus_Inicio;
Procedure BarraMenus_Fin;

Implementation

Uses Forms, Data, Vars;

Procedure Fnc_Destruir( Sender:PVisualOBject ); Far; Forward;
Procedure Fnc_Nuevo( Sender:PVisualObject ); Far; Forward;


{ MENU "ARCHIVO" }
Procedure Fnc_ActivaArchivo( Sender:PVisualObject ); Far;
Begin
     with mnuArchivo^ do begin
        SetLeft( btnArchivo^.GetLeft );
        SetTop( btnArchivo^.GetTop );
        DrawAll;
        Test;
     end;
End;

Procedure Fnc_Crear( Sender:PVisualOBject ); Far;
Begin
     if Creado then if Confirmation( 'Nueva DB','¨Crear una nueva base de datos?','Si','No') then DB.Done;
     DB.Init;
     if NOT( Creado ) then begin
        Creado:=TRUE;
        Modificado:=TRUE;
        btnRegistro^.Active:=TRUE;
        mitDestruir^.Active:=TRUE;
        mitGuardar^.Active:=TRUE;
        mitGuardarComo^.Active:=TRUE;
     end;
End;

Procedure Fnc_Destruir( Sender:PVisualOBject );
Begin
     if Creado then if Confirmation( 'Destruir DB','¨Destruir la actual base de datos?','Si','No') then begin
        DB.Done;
        Creado:=FALSE;
        Modificado:=FALSE;
        btnRegistro^.Active:=FALSE;
        mitDestruir^.Active:=FALSE;
        mitGuardar^.Active:=FALSE;
        mitGuardarComo^.Active:=FALSE;
     end;
End;

Procedure Fnc_Abrir( Sender:PVisualObject ); Far;
Var Temp : TJugador;
Begin
     if Creado then if Confirmation( 'Nueva DB','¨Crear una nueva base de datos?','Si','No') then DB.Done;
     DB.Init;
     if InputQuery( 'Abrir DB','Abrir','Cancelar',NombreArchivo ) then begin
        if NOT( FileExists( NombreArchivo ) ) then ShowMsg( 'Error','"'+NombreArchivo+'" no existe','Aceptar' )
        else begin
           DB.Carga( NombreArchivo );
           Temp:=DB.DameJugador( 1 )^;
           Creado:=TRUE;
           btnRegistro^.Active:=TRUE;
           mitDestruir^.Active:=TRUE;
           mitGuardar^.Active:=TRUE;
           mitGuardarComo^.Active:=TRUE;
           ShowMsg( '','Se han cargado '+IntToStr(DB.DameNumRegistros)+' registros','Aceptar' );
        end;
     end;
End;

Procedure Fnc_Guardar( Sender:PVisualObject ); Far;
Var Temp : TJugador;
Begin
     if Confirmation( 'Guardar DB...','¨Desea guardar los cambios en "'+NombreArchivo+'"?','Guardar','Cancelar' ) then begin
        DB.Guarda( NombreArchivo );
        Modificado:=FALSE;
     end;
End;

Procedure Fnc_GuardarComo( Sender:PVisualObject ); Far;
Begin
     if InputQuery( 'Guardar DB como...','Aceptar','Cancelar',NombreArchivo ) then begin
        if Confirmation( 'Guardar DB','¨Desea guardar los cambios en "'+NombreArchivo+'"?','Guardar','Cancelar' ) then begin
           DB.Guarda( NombreArchivo );
           Modificado:=FALSE;
        end;
     end;
End;

Procedure Fnc_Salir( Sender:PVisualObject ); Far;
Begin
     if Modificado then begin
        if Confirmation( 'Salir','¨Salir sin guardar los cambios?','Si','No' ) then begin
           if Creado then DB.Done;
           Salir:=TRUE;
        end else begin
           Fnc_GuardarComo( Sender );
           Salir:=NOT( Modificado );
        end;
     end else if Confirmation( 'Salir','¨Salir del programa?','Si','No' ) then Salir:=TRUE;
End;

{ MENU "REGISTRO" }
Procedure Fnc_ActivaRegistro( Sender:PVisualObject ); Far;
Begin
     with mnuRegistro^ do begin
        SetLeft( btnRegistro^.GetLeft );
        SetTop( btnRegistro^.GetTop );
        DrawAll;
        Test;
     end;
End;

Procedure Fnc_Nuevo( Sender:PVisualObject );
Var Temp : PJugador;
Begin
     New( Temp );
     with Temp^ do begin
        Nombre:='';
        PApellido:='';
        SApellido:='';
        ANacim:=1950;
        MNacim:=1;
        DNacim:=1;
        Foto:=TRUE;
        PathFoto:='';
     end;
     Temp:=RecogeDatos( Temp,NoEliminar );
     if NOT( Temp=NIL ) then begin
        DB.InsertaJugador( Temp^ );
        Modificado:=TRUE;
     end;
End;

Procedure Fnc_Mostrar( Sender:PVisualObject ); Far;
Var S        : String;
    TempBool : Boolean;
    TempInt  : Integer;
    TempPtr  : PJugador;
Begin
     if DB.DameNumRegistros=0 then ShowMsg( '','No hay registros que mostrar','Aceptar' ) else begin
        S:='';
        TempInt:=-1;
        repeat
           TempBool:=InputQuery( 'Mostrar registro','Aceptar','Cancelar',S );
           TempInt:=StrToInt( S );
        until NOT( TempBool ) OR ( (TempInt>=1) AND (TempInt<=DB.DameNumRegistros) );
        if TempBool then begin
           TempPtr:=DB.DameJugador( TempInt );
           if NOT( TempPtr=NIL ) then begin
              RegActual:=TempInt;
              RecogeDAtos( TempPtr,Eliminar );
           end;
        end;
     end;
End;


{ MENU "AYUDA" }
Procedure Fnc_ActivaAyuda( Sender:PVisualObject ); Far;
Begin
     with mnuAyuda^ do begin
        SetLeft( btnAyuda^.GetLeft );
        SetTop( btnAyuda^.GetTop );
        DrawAll;
        Test;
     end;
End;

Procedure Fnc_AcercaDe( Sender:PVisualObject ); Far;
Begin
     ShowMsg( 'Acerca de...',
              '(c)1998-1999 Luis Rafael Medel C ceres',
              'Aceptar' );
End;

{ ==== FIN DE LAS OPCIONES DE LOS MENUS =================================== }

Procedure BarraMenus_Inicio;
Begin
     New( pnlDesktop );

     New( pnlBarraBotones );


     New( btnArchivo );
     New( mnuArchivo );
     New( mitCrear );
     New( mitDestruir );
     New( mitSeparadorArchivo1 );
     New( mitAbrir );
     New( mitGuardar );
     New( mitGuardarComo );
     New( mitSeparadorArchivo2 );
     New( mitSalir );

     New( btnRegistro );
     New( mnuRegistro );
     New( mitNuevo );
     New( mitSeparadorRegistro1 );
     New( mitMostrar );

     New( btnAyuda );
     New( mnuAyuda );
     New( mitAcercaDe );

    { **** Archivo **** }
    { Boton }
    with btnArchivo^ do begin
       Init( pnlBarraBotones,btnRegistro,NIL );
       Caption:='Archivo';
       Action:=Fnc_ActivaArchivo;
       SetWidth( AnchoBotones );
       SetHeight( AltoBotones );
       SetLeft( BorderSize );
       SetTop( BorderSize );
    end;
    { Opciones del menu }
    with mitCrear^ do begin
       Init( mnuArchivo,mitDestruir,NIL );
       Caption:='Crear DB';
       Action:=Fnc_Crear;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitDestruir^ do begin
       Init( mnuArchivo,mitSeparadorArchivo1,NIL );
       Caption:='Destruir DB';
       Action:=Fnc_Destruir;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
       Active:=FALSE;
    end;
    with mitSeparadorArchivo1^ do begin
       Init( mnuArchivo,mitAbrir,NIL );
       Caption:='-';
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitAbrir^ do begin
       Init( mnuArchivo,mitGuardar,NIL );
       Caption:='Abrir...';
       Action:=Fnc_Abrir;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitGuardar^ do begin
       Init( mnuArchivo,mitGuardarComo,NIL );
       Caption:='Guardar...';
       Action:=Fnc_Guardar;
       Active:=FALSE;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitGuardarComo^ do begin
       Init( mnuArchivo,mitSeparadorArchivo2,NIL );
       Caption:='Guardar como...';
       Action:=Fnc_GuardarComo;
       Active:=FALSE;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitSeparadorArchivo2^ do begin
       Init( mnuArchivo,mitSalir,NIL );
       Caption:='-';
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitSalir^ do begin
       Init( mnuArchivo,NIL,NIL );
       Caption:='Salir...';
       Action:=Fnc_Salir;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    mnuArchivo^.Init( NIL,NIL,mitCrear );
    mnuArchivo^.ParentObject:=pnlBarraBotones;

    { **** Registro **** }
    with btnRegistro^ do begin
       Init( pnlBarraBotones,btnAyuda,NIL );
       Caption:='Registro';
       Action:=Fnc_ActivaRegistro;
       Active:=FALSE;
       SetWidth( AnchoBotones );
       SetHeight( AltoBotones );
       SetLeft( BorderSize+AnchoBotones+1 );
       SetTop( BorderSize );
    end;
    { Opciones del menu }
    with mitNuevo^ do begin
       Init( mnuRegistro,mitSeparadorRegistro1,NIL );
       Caption:='Nuevo...';
       Action:=Fnc_Nuevo;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitSeparadorRegistro1^ do begin
       Init( mnuRegistro,mitMostrar,NIL );
       Caption:='-';
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    with mitMostrar^ do begin
       Init( mnuRegistro,NIL,NIL );
       Caption:='Mostrar...';
       Action:=Fnc_Mostrar;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    mnuRegistro^.Init( NIL,NIL,mitNuevo );
    mnuRegistro^.ParentObject:=pnlBarraBotones;

    { **** Ayuda ****}
    with btnAyuda^ do begin
       Init( pnlBarraBotones,NIL,NIL );
       Caption:='Ayuda';
       Action:=Fnc_ActivaAyuda;
       SetWidth( AnchoBotones );
       SetHeight( AltoBotones );
       SetLeft( BorderSize+( (AnchoBotones+1) SHL 1) );
       SetTop( BorderSize );
    end;
    with mitAcercaDe^ do begin
       Init( mnuAyuda,NIL,NIL );
       Caption:='Acerca de...';
       Action:=Fnc_AcercaDe;
       SetWidth( TextWidth( Caption ) );
       SetHeight( 12 );
    end;
    mnuAyuda^.Init( NIL,NIL,mitAcercaDe );
    mnuAyuda^.ParentObject:=pnlBarraBotones;


    with pnlBarraBotones^ do begin
       Init( NIL,NIL,btnArchivo );
       SetLeft( 0 );
       SetTop( 0 );
       SetWidth( MaxX-1 );
       SetHeight( AltoBotones+(BorderSize*2) );
    end;

    with pnlDesktop^ do begin
       Init( NIL,NIL,NIL );
       SetLeft( -1 );
       SetTop( -1 );
       SetWidth( MaxX+1 );
       SetHeight( MaxY+1 );
    end;
End;

Procedure BarraMenus_Fin;
Begin
    pnlDesktop^.Done;
    Dispose( pnldesktop );

    pnlBarraBotones^.Done;
    Dispose( pnlBarraBotones );

    btnArchivo^.Done;
    mnuArchivo^.Done;
    mitCrear^.Done;
    mitDestruir^.Done;
    mitSeparadorArchivo1^.Done;
    mitAbrir^.Done;
    mitGuardar^.Done;
    mitGuardarComo^.Done;
    mitSeparadorArchivo2^.Done;
    mitSalir^.Done;
    Dispose( mitCrear );
    Dispose( mitDestruir );
    Dispose( mitSeparadorArchivo1 );
    Dispose( btnArchivo );
    Dispose( mnuArchivo );
    Dispose( mitAbrir );
    Dispose( mitGuardar );
    Dispose( mitGuardarComo );
    Dispose( mitSeparadorArchivo2 );
    Dispose( mitSalir );

    btnRegistro^.Done;
    mnuRegistro^.Done;
    mitNuevo^.Done;
    mitSeparadorRegistro1^.Done;
    mitMostrar^.Done;
    Dispose( btnRegistro );
    Dispose( mnuRegistro );
    Dispose( mitNuevo );
    Dispose( mitSeparadorRegistro1 );
    Dispose( mitMostrar );

    btnAyuda^.Done;
    mnuAyuda^.Done;
    mitAcercaDe^.done;
    Dispose( btnAyuda );
    Dispose( mnuAyuda );
    Dispose( mitAcercaDe );
End;


End.