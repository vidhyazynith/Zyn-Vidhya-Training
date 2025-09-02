page 50110 "Index List Page"
{
    PageType = List;
    SourceTable ="Index table";
    ApplicationArea = ALL;
    Caption = 'Index List';
    CardPageID = "Index Card Page"; 
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
                field("Description";Rec.Description)
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