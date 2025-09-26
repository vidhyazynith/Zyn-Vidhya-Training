page 50156 Zyn_AssetHistoryFactbox
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Zyn_Employee Asset Table";
    Caption = 'Asset History';
    layout
    {
        area(Content)
        {
            cuegroup("Asset history")
            {
                field(Count; Count)
                {
                    Caption = 'Count';
                    DrillDown = true;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        AssetRec: Record "Zyn_Employee Asset Table";
                    begin
                        AssetRec.Reset();
                        PAGE.Run(PAGE::"Zyn_Employee Asset list", AssetRec);
                    end;
                }

            }
        }

    }
    var
        Count: Integer;

    trigger OnAfterGetRecord()
    var
        AssetRec: Record "Zyn_Employee Asset Table";
    begin
        AssetRec.Reset();
        Count := AssetRec.Count;
    end;
}