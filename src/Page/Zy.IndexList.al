page 50110 "Zyn_Index List"
{
    PageType = List;
    SourceTable = "Zyn_Index table";
    ApplicationArea = ALL;
    Caption = 'Index List';
    CardPageID = "Zyn_Index Card";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Percentage Increase"; Rec."Per. Increase")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}