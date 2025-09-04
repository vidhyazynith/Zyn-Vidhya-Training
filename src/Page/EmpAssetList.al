page 50153 "EmpAssetList"
{
    PageType = List;
    SourceTable ="Employee Asset Table";
    ApplicationArea = ALL;
    Caption = 'Employee Asset List';
    CardPageID = "Employee Asset Card"; 
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Employee Asset Id"; Rec."Emp. Ass ID")
                // { }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea =All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Assigned Date"; Rec."Assigned date")
                {
                    ApplicationArea = All;
                }
                field("Returned date"; Rec."Returned date")
                {
                    ApplicationArea = All;
                }
                field("Lost date"; Rec."Lost date")
                {
                    ApplicationArea = All;
                }
                
                }


            }
        area(FactBoxes)
        {
            part(AssetHis; "Asset history Factbox") { 
                ApplicationArea = All;  }
        }
}
}
