page 50113 Zyn_PostedBeginTextListPart
{
    PageType = ListPart;
    SourceTable = Zyn_ExtendedTextTable;
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
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; rec."Sales Document Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

