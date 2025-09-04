page 50156 "Asset history Factbox"
{
    PageType = CardPart;
    ApplicationArea = All;
    SourceTable = "Employee Asset Table";
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
                        AssetRec: Record "Employee Asset Table";
                    begin
                        AssetRec.Reset();
                        PAGE.Run(PAGE::EmpAssetList, AssetRec);
                    end;
                }
            
        }
    }
    
    }
    var
        Count: Integer;

    trigger OnAfterGetRecord()
    var
        AssetRec: Record "Employee Asset Table";
    begin
        AssetRec.Reset();
        Count := AssetRec.Count;
    end;
}