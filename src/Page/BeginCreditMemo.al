page 50115 Zyn_BeginningTextCreditMemo
{
    PageType = ListPart;
    SourceTable = Zyn_ExtendedTextTable;
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

            }
        }
    }
}

