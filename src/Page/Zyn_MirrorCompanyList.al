page 50166 "Zyn_Company List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Zyn_Company Table";
    UsageCategory = Lists;
    Caption = 'Zynith Company List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Display Name"; Rec."Display Name")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Company"; Rec."Evaluation Company")
                {
                    ApplicationArea = All;
                }
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                }
                field("IsMaster"; Rec."Is Master")
                {
                    ApplicationArea = All;
                }
                field("Master Company Name"; Rec."Master Company Name")
                {
                    ApplicationArea = All;
                }
                field("Business Profile Id"; Rec."Business Profile Id")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}

