page 50129 "Zyn_Leave Category List"
{
    PageType = List;
    SourceTable = "Zyn_Leave Category Table";
    ApplicationArea = ALL;
    Caption = 'Leave Category List';
    CardPageID = "Zyn_Leave Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category ID"; Rec."Leave Cat. ID")
                {
                    ApplicationArea = All;
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. of Days Allowed"; Rec."Allowed Days")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}