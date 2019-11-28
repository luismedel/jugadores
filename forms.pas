Unit Forms;

Interface

Uses GUI_Mous, GUI_Gen,  GUI_Gfx,  GUI_Base,
     GUI_Btns, GUI_Text, GUI_CBox, GUI_Img,
     GUI_Capt, GUI_Wnd,  GUI_Labl, GUI_Font,
     GUI_Panl, GUI_Menu, GUI_Diag,
     Barra, Vars, Data;

Const Eliminar   = TRUE;
      NoEliminar = FALSE;

Function RecogeDatos( Jugador:PJugador; Modo:Boolean ) : PJugador;

Implementation

Var wndForm          : PWindow;
       lblNombre     : PLabel;
       txtNombre     : PTextBox;
       lblPApellido  : PLabel;
       txtPApellido  : PTextBox;
       lblSApellido  : PLabel;
       txtSApellido  : PTextBox;
       lblFechaNacim : PLabel;
       lblANacim     : PLabel;
       txtANacim     : PTextBox;
       lblMNacim     : PLabel;
       txtMNacim     : PTextBox;
       lblDNacim     : PLabel;
       txtDNacim     : PTextBox;
       chkConFoto    : PCheckBox;
       lblPath       : PLabel;
       txtPath       : PTextBox;
       imgFoto       : PImage;
       btnAceptar    : PButton;
       btnCancelar   : PButton;
       btnEliminar   : PButton;

Const NoResult     = 0;
      Result_TRUE  = 1;
      Result_FALSE = 2;

Var Result    : Integer;
    Eliminado : Boolean;

Procedure GetTRUE( Sender:PVisualObject ); Far;
Begin
     Result:=Result_TRUE;
End;

Procedure GetFALSE( Sender:PVisualObject ); Far;
Begin
     Result:=Result_FALSE;
End;

Procedure Fnc_Eliminar( Sender:PVisualObject ); Far;
Begin
     if Confirmation( 'Eliminar registro','¨Eliminar el registro actual?','Si','No' ) then begin
        DB.BorraJugador( RegActual );
        Modificado:=TRUE;
        Eliminado:=TRUE;
     end;
End;

Function RecogeDatos( Jugador:PJugador; Modo:Boolean ) : PJugador;
Const TamX = 300;
      TamY = 350;
Var YPos : Integer;
    Temp : PJugador;
Begin
     if Jugador=NIL then Exit;

     New( wndForm );
     New( lblNombre );
     New( txtNombre );
     New( lblPApellido );
     New( txtPApellido );
     New( lblSApellido );
     New( txtSApellido );
     New( lblFechaNacim );
     New( lblANacim );
     New( txtANacim );
     New( lblMNacim );
     New( txtMNacim );
     New( lblDNacim );
     New( txtDNacim );
     New( chkConFoto );
     New( lblPath );
     New( txtPath );
     New( imgFoto );
     New( btnAceptar );
     New( btnCancelar );
     New( btnEliminar );

     YPos:=DefaultWndTitlebarSize+(BorderSize*3);
     with lblNombre^ do begin
        Init( wndForm,txtNombre,NIL );
        Caption:='Nombre:';
        SetLeft( (BorderSize*2) );
        SetTop( YPos );
        Inc( YPos,BorderSize+GetHeight )
     end;
     with txtNombre^ do begin
        Init( wndForm,lblPApellido,NIL );
        MaxLength:=SizeOf( TNombre ) - 1;
        Text:=Jugador^.Nombre;
        SetLeft( BorderSize*4 );
        SetTop( YPos );
     end;
     with lblPApellido^ do begin
        Init( wndForm,txtPApellido,NIL );
        Caption:='1er apellido:';
        SetLeft( 130 );
        SetTop( lblNombre^.GetTop );
     end;
     with txtPApellido^ do begin
        Init( wndForm,lblSApellido,NIL );
        MaxLength:=SizeOf( TNombre ) - 1;
        Text:=Jugador^.PApellido;
        SetLeft( lblPApellido^.GetLeft+BorderSize );
        SetTop( txtNombre^.GetTop );
        Inc( YPos,GetHeight+(BorderSize*3) );
     end;
     with lblSApellido^ do begin
        Init( wndForm,txtSApellido,NIL );
        Caption:='2§ apellido:';
        SetLeft( (BorderSize*2) );
        SetTop( YPos );
        Inc( YPos,GetHeight+BorderSize )
     end;
     with txtSApellido^ do begin
        Init( wndForm,lblFechaNacim,NIL );
        MaxLength:=SizeOf( TNombre ) - 1;
        Text:=Jugador^.SApellido;
        SetLeft( BorderSize*4 );
        SetTop( YPos );
        Inc( YPos,GetHeight+(BorderSize*5) )
     end;
     with lblFechaNAcim^ do begin
        Init( wndForm,lblANacim,NIL );
        Caption:='Fecha de nacimiento:';
        SetLeft( BorderSize*2 );
        SetTop( YPos );
        Inc( YPos,GetHeight+(BorderSize*3) )
     end;
     with lblANacim^ do begin
        Init( wndForm,txtANacim,NIL );
        Caption:='A¤o';
        SetLeft( BorderSize*2 );
        SetTop( YPos );
        Inc( YPos,GetHeight+BorderSize )
     end;
     with txtANacim^ do begin
        Init( wndForm,lblMNacim,NIL );
        MaxLength:=4;
        Text:=IntToStr( Jugador^.ANacim );
        SetLeft( BorderSize*2 );
        SetTop( YPos );
        IsNumber:=TRUE;
        SetWidth( DefaultTxtBoxWidth DIV 2 );
        Inc( YPos,GetHeight+(BorderSize*2) )
     end;
     with lblMNacim^ do begin
        Init( wndForm,txtMNacim,NIL );
        Caption:='Mes';
        SetLeft( 70 );
        SetTop( lblANacim^.GetTop );
     end;
     with txtMNacim^ do begin
        Init( wndForm,lblDNacim,NIL );
        MaxLength:=2;
        Text:=IntToStr( Jugador^.MNacim );
        IsNumber:=TRUE;
        SetLeft( lblMNacim^.GetLeft );
        SetTop( txtANacim^.GetTop );
        SetWidth( DefaultTxtBoxWidth DIV 2 );
     end;
     with lblDNacim^ do begin
        Init( wndForm,txtDNacim,NIL );
        Caption:='D¡a';
        SetLeft( 140 );
        SetTop( lblMNacim^.GetTop );
     end;
     with txtDNacim^ do begin
        Init( wndForm,chkConFoto,NIL );
        MaxLength:=2;
        Text:=IntToStr( Jugador^.DNacim );
        IsNumber:=TRUE;
        SetLeft( lblDNacim^.GetLeft );
        SetTop( txtMNacim^.GetTop );
        SetWidth( DefaultTxtBoxWidth DIV 2 );
        Inc( YPos,GetHeight+(BorderSize*3) )
     end;
     with chkConFoto^ do begin
        Init( wndForm,lblPath,NIL );
        Caption:='Incluye fotograf¡a';
        Checked:=Jugador^.Foto;
        SetLeft( BorderSize );
        SetTop( YPos );
        Inc( YPos,GetHeight+(BorderSize*3) )
     end;
     with lblPath^ do begin
        Init( wndForm,txtPath,NIL );
        Caption:='Path a la imagen (.RAW):';
        Active:=FALSE;
        SetLeft( BorderSize*2 );
        SetTop( YPos );
        Inc( YPos,GetHeight+BorderSize )
     end;
     with txtPath^ do begin
        Init( wndForm,imgFoto,NIL );
        MaxLength:=254;
        Text:=Jugador^.PathFoto;
        SetLeft( BorderSize*2 );
        SetTop( YPos );
     end;
     with imgFoto^ do begin
        Init( wndForm,btnAceptar,NIL );
        if Jugador^.Foto then begin
           Path:=Jugador^.PathFoto;
           Load;
        end;
        SetLeft( 130 );
        SetTop( YPos );
        Inc( YPos,GetHeight+(BorderSize*4) )
     end;
     with btnAceptar^ do begin
        Init( wndForm,btnCancelar,NIL );
        Caption:='Aceptar';
        Action:=GetTrue;
        SetLeft( TamX-(BorderSize*2)-(DefaultBtnWidth*2) );
        SetTop( TamY-BorderSize-DefaultBtnHeight );
     end;
     with btnCancelar^ do begin
        Init( wndForm,btnEliminar,NIL );
        Caption:='Cancelar';
        Action:=GetFalse;
        SetLeft( btnAceptar^.GetLeft+DefaultBtnWidth+BorderSize );
        SetTop( TamY-BorderSize-DefaultBtnHeight );
     end;
     with btnEliminar^ do begin
        Init( wndForm,NIL,NIL );
        Caption:='Elminar';
        Action:=Fnc_Eliminar;
        Active:=Modo;
        SetLeft( (BorderSize*2) );
        SetTop( btnCancelar^.GetTop );
     end;

     with wndForm^ do begin
        Init( NIL,lblNombre );
        SetLeft( 0 );
        SetTop( pnlBarraBotones^.GetHeight+1 );
        SetWidth( TamX );
        SetHeight( TamY );
     end;

     wndForm^.DrawAll;
     Eliminado:=FALSE;
     Result:=NoResult;
     repeat
        wndForm^.Test;
     until Eliminado or NOT( Result=NoResult );
     wndForm^.RestoreBG;

     New( Temp );
     with Temp^ do begin
        Nombre:=txtNombre^.Text;
        PApellido:=txtPApellido^.Text;
        SApellido:=txtSApellido^.Text;
        ANacim:=StrToInt( txtANacim^.Text );
        MNacim:=StrToInt( txtMNacim^.Text );
        DNacim:=StrToInt( txtDNacim^.Text );
        Foto:=chkConFoto^.Checked;
        PathFoto:=txtPath^.Text;
     end;
     if Result=Result_TRUE then RecogeDatos:=Temp else RecogeDatos:=NIL;

     wndForm^.Done;
     lblNombre^.Done;
     txtNombre^.Done;
     lblPApellido^.Done;
     txtPApellido^.Done;
     lblSApellido^.Done;
     txtSApellido^.Done;
     lblANacim^.Done;
     txtANacim^.Done;
     lblMNacim^.Done;
     txtMNacim^.Done;
     lblDNacim^.Done;
     txtDNacim^.Done;
     chkConFoto^.Done;
     lblPath^.Done;
     txtPath^.Done;
     imgFoto^.Done;
     btnAceptar^.Done;
     btnCancelar^.Done;
     btnEliminar^.Done;

     Dispose( wndForm );
     Dispose( lblNombre );
     Dispose( txtNombre );
     Dispose( lblPApellido );
     Dispose( txtPApellido );
     Dispose( lblSApellido );
     Dispose( txtSApellido );
     Dispose( lblANacim );
     Dispose( txtANacim );
     Dispose( lblMNacim );
     Dispose( txtMNacim );
     Dispose( lblDNacim );
     Dispose( txtDNacim );
     Dispose( chkConFoto );
     Dispose( lblPath );
     Dispose( txtPath );
     Dispose( imgFoto );
     Dispose( btnAceptar );
     Dispose( btnCancelar );
     Dispose( btnEliminar );
End;

End.
