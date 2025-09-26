page 50117 Zyn_EndingTextCreditMemo
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

