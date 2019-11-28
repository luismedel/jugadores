Unit GUI_Font;

Interface

Uses GUI_Gfx;

Type TFontStyle = Set of ( fsBold, fsItalic, fsUnderline );

     TFont = Record
        FontFace : String;
        Color    : TColor;
        Style    : TFontStyle;
     End;

Implementation

End.