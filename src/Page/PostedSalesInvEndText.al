page 50114 "Posted Ending Text ListPart"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
                field("Document Type"; rec."Sales Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }

            }
        }
    }
}

