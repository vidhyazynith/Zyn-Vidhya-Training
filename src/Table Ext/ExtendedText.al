tableextension 50104 ExtendedTextLineExt extends "Extended Text Line"
{
    fields
    {
        field(50100; Bold; Boolean)
        {
            Caption = 'Bold';
            DataClassification = ToBeClassified;
        }

        field(50101; Italic; Boolean)
        {
            Caption = 'Italic';
            DataClassification = ToBeClassified;
        }

        field(50102; Underline; Boolean)
        {
            Caption = 'Underline';
            DataClassification = ToBeClassified;
        }
    }
}
