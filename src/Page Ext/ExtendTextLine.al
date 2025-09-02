pageextension 50103 "ExtendtextPage" extends "Extended Text Lines"
{
    layout
    {
        addafter("Text") 
        {
            field(Bold; Rec.Bold)       
            {
                ApplicationArea = All;
                Caption = 'Bold';
            }
            field(Italic; Rec.Italic)
            {
                ApplicationArea = All;
                Caption = 'Italic';
            }
            field(Underline; Rec.Underline)
            {
                ApplicationArea = All;
                Caption = 'Underline';
            }
        }
    }
}
