page 50101 "Field Lookup Buffer Page"
{
    PageType = List;
    SourceTable = "Field Lookup Buffer";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FieldName"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                }
                field("Field ID"; Rec.ID)
                {
                    ApplicationArea = All;
                    Caption = 'Field ID';
                }
            }
        }
    }
}
