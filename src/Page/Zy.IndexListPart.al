page 50142 "Zyn_Index ListPart"
{
    PageType = ListPart;
    SourceTable = "Zyn_Index ListPart Table";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Year"; rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

