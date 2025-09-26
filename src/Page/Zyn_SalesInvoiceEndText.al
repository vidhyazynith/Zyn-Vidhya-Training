page 50120 Zyn_EndingTextListPart
{
    PageType = ListPart;
    SourceTable = Zyn_ExtendedTextTable;
    ApplicationArea = All;
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
                field("Text"; rec."Text")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
