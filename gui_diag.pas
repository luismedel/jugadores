Unit GUI_Diag;

Interface

Uses GUI_Gen, GUI_Gfx, GUI_Capt, GUI_Font,
     GUI_Btns, GUI_Text, GUI_CBox, GUI_Wnd,
     GUI_Labl, GUI_Base, GUI_Mous;

Procedure ShowMsg( WndCaption:TCaption; Message:String; BtnCaption:TCaption );
Function Confirmation( WndCaption:TCaption; Message:String; YesCaption, NoCaption:TCaption ) : Boolean;
Function InputQuery( Message:String; OkCaption,CancelCaption:TCaption; Var S:String ) : Boolean;

Implementation

Const NoResult     = 0;
      Result_TRUE  = 1;
      Result_FALSE = 2;

Var Result : Integer;

Procedure GetTRUE( Sender:PVisualObject ); Far;
Begin
     Result:=Result_TRUE;
End;

Procedure GetFALSE( Sender:PVisualObject ); Far;
Begin
     Result:=Result_FALSE;
End;

Procedure ShowMsg( WndCaption:TCaption; Message:String; BtnCaption:TCaption );
Var TempW  : Integer;
    TempH  : Integer;

    Wnd    : PWindow;
    Lbl    : PLabel;
    Btn    : PButton;

Begin
     New( Wnd );
     New( Lbl );
     New( Btn );

     with Wnd^ do begin
        Init( NIL,Lbl );
        Caption:=WndCaption;
        TempW:=TextWidth(Message) + (BorderSize*12);
        if TempW<(DefaultBtnWidth*2)+(BorderSize*8) then
           TempW:=(DefaultBtnWidth*2)+(BorderSize*8);
        TempH:=( TextHeight(Message) SHL 1 ) + 75;
        SetWidth( TempW );
        SetHeight( TempH );
        SetLeft( 320-(TempW SHR 1) );
        SetTop( 240-(TempH SHR 1) );
     end;

     with Lbl^ do begin
        Init( Wnd,Btn,NIL );
        Caption:=Message;
        SetLeft( BorderSize*3 );
        SetTop( 25 );
        SetWidth( TextWidth(Caption) );
        SetHeight( TextHeight(Caption) );
     end;

     with Btn^ do begin
        Init( Wnd,NIL,NIL );
        Caption:=BtnCaption;
        Active:=TRUE;
        Action:=GetTRUE;
        SetLeft( (ParentObject^.GetWidth DIV 2) - (GetWidth DIV 2) );
        SetTop( ParentObject^.GetHeight - BorderSize - GetHeight )
     end;

     Wnd^.DrawAll;
     Result:=NoResult;
     repeat Wnd^.Test until NOT( Result=NoResult );

     Wnd^.RestoreBG;

     Wnd^.Done;
     Dispose( Wnd );
     Lbl^.Done;
     Dispose( Lbl );
     Btn^.Done;
     Dispose( Btn );
End;

Function Confirmation( WndCaption:TCaption; Message:String; YesCaption, NoCaption:TCaption ) : Boolean;
Var TempW  : Integer;
    TempH  : Integer;

    Wnd    : PWindow;
    Lbl    : PLabel;
    YesBtn : PButton;
    NoBtn  : PButton;

Begin
     New( Wnd );
     New( Lbl );
     New( YesBtn );
     New( NoBtn );

     with Wnd^ do begin
        Init( NIL,Lbl );
        Caption:=WndCaption;
        TempW:=TextWidth(Message) + (BorderSize*12);
        if TempW<(DefaultBtnWidth*2)+(BorderSize*8) then
           TempW:=(DefaultBtnWidth*2)+(BorderSize*8);
        TempH:=( TextHeight(Message) SHL 1 ) + 75;
        SetWidth( TempW );
        SetHeight( TempH );
        SetLeft( 320-(TempW SHR 1) );
        SetTop( 240-(TempH SHR 1) );
     end;

     with Lbl^ do begin
        Init( Wnd,YesBtn,NIL );
        Caption:=Message;
        SetLeft( BorderSize*3 );
        SetTop( 25 );
        SetWidth( TextWidth(Caption) );
        SetHeight( TextHeight(Caption) );
     end;

     with YesBtn^ do begin
        Init( Wnd,NoBtn,NIL );
        Caption:=YesCaption;
        Active:=TRUE;
        Action:=GetTRUE;
        SetLeft( (ParentObject^.GetWidth DIV 2) - BorderSize - GetWidth );
        SetTop( ParentObject^.GetHeight - BorderSize - GetHeight )
     end;

     with NoBtn^ do begin
        Init( Wnd,NIL,NIL );
        Caption:=NoCaption;
        Active:=TRUE;
        Action:=GetFALSE;
        SetLeft( (ParentObject^.GetWidth DIV 2) + BorderSize );
        SetTop( ParentObject^.GetHeight - BorderSize - GetHeight )
     end;

     Wnd^.DrawAll;
     Result:=NoResult;
     repeat Wnd^.Test until NOT( Result=NoResult );
     Confirmation:=(Result=Result_TRUE);

     Wnd^.RestoreBG;

     Wnd^.Done;
     Dispose( Wnd );
     Lbl^.Done;
     Dispose( Lbl );
     YesBtn^.Done;
     Dispose( YesBtn );
     NoBtn^.Done;
     Dispose( NoBtn );
End;

Function InputQuery( Message:String; OkCaption,CancelCaption:TCaption; Var S:String ) : Boolean;
Var TempW  : Integer;
    TempH  : Integer;

    Wnd        : PWindow;
    Lbl        : PLabel;
    TextBox    : PTextBox;
    OkBtn      : PButton;
    CancelBtn  : PButton;
Begin
     New( Wnd );
     New( Lbl );
     New( TextBox );
     New( OkBtn );
     New( CancelBtn );

     with Wnd^ do begin
        Init( NIL,Lbl );
        Caption:='';
        TempW:=TextWidth(Message) + (BorderSize*12);
        if TempW<(DefaultBtnWidth*2)+(BorderSize*8) then
           TempW:=(DefaultBtnWidth*2)+(BorderSize*8);
        TempH:=( TextHeight(Message) SHL 1 ) + 75;
        SetWidth( TempW );
        SetHeight( TempH );
        SetLeft( 320-(TempW SHR 1) );
        SetTop( 240-(TempH SHR 1) );
     end;

     with Lbl^ do begin
        Init( Wnd,TextBox,NIL );
        Caption:=Message;
        SetLeft( BorderSize*3 );
        SetTop( 25 );
        SetWidth( TextWidth(Caption) );
        SetHeight( TextHeight(Caption) );
     end;

     with TextBox^ do begin
        Init( Wnd,OkBtn,NIL );
        Text:=S;
        SetWidth( 150 );
        SetLeft( BorderSize*3 );
        SetTop( 40 );
     end;

     with OkBtn^ do begin
        Init( Wnd,CancelBtn,NIL );
        Caption:=OkCaption;
        Active:=TRUE;
        Action:=GetTRUE;
        SetLeft( ParentObject^.GetWidth - (BorderSize*3) - (GetWidth*2) );
        SetTop( ParentObject^.GetHeight - BorderSize - GetHeight )
     end;

     with CancelBtn^ do begin
        Init( Wnd,NIL,NIL );
        Caption:=CancelCaption;
        Active:=TRUE;
        Action:=GetFALSE;
        SetLeft( ParentObject^.GetWidth - BorderSize - GetWidth );
        SetTop( ParentObject^.GetHeight - BorderSize - GetHeight )
     end;

     Wnd^.DrawAll;
     Result:=NoResult;
     repeat Wnd^.Test until NOT( Result=NoResult );
     if (Result=Result_TRUE) then S:=TextBox^.Text;
     InputQuery:=(Result=Result_TRUE);

     Wnd^.RestoreBG;

     Wnd^.Done;
     Dispose( Wnd );
     Lbl^.Done;
     Dispose( Lbl );
     TextBox^.Done;
     Dispose( Textbox );
     OkBtn^.Done;
     Dispose( OkBtn );
     CancelBtn^.Done;
     Dispose( CancelBtn );

End;

End.