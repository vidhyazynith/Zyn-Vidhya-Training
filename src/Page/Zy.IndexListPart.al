page 50142 "Index List Part"
{
    PageType = ListPart;
    SourceTable = "Index List Part";
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
                    Caption = 'Year';
                }
                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Caption = 'Value';
                }
            }
        }
    }
}

