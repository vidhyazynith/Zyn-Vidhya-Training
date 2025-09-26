page 50101 Zyn_FieldLookupBufferPage
{
    PageType = List;
    SourceTable = "Zyn_Field Lookup Buffer";
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
                }
                field("Field ID"; Rec.ID)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
