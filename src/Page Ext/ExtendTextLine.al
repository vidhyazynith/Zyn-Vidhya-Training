pageextension 50103 Zyn_ExtendtextLinesExt extends "Extended Text Lines"
{
    layout
    {
        addafter("Text")
        {
            field(Bold; Rec.Bold)
            {
                ApplicationArea = All;
            }
            field(Italic; Rec.Italic)
            {
                ApplicationArea = All;
            }
            field(Underline; Rec.Underline)
            {
                ApplicationArea = All;
            }
        }
    }
}
