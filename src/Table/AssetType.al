table 50110 "Zyn_Asset Type Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Asset Type ID"; Integer)
        {
            Caption = 'Asset Type ID';
            ToolTip = 'Specifies the unique system-generated identification number for each asset type.';
            AutoIncrement = true;
        }
        field(2; "Asset Category"; Enum "Zyn_Asset Category")
        {
            Caption = 'Asset Category';
            ToolTip = 'Specifies the category under which this asset type falls, such as Infrastructure, Electronics, etc.';
        }
        field(3; "Name"; text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the asset type, such as Laptop, Chair, etc.';
        }
    }

    keys
    {
        key(PK; "Asset Type ID", Name)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        AssetRec: Record "Zyn_Assets Table";
        EmpAssetRec: Record "Zyn_Employee Asset Table";
    begin

        AssetRec.Reset();
        AssetRec.SetRange("Asset Type", Rec.Name);
        if AssetRec.FindSet() then
            repeat
                AssetRec.Delete(true);
            until AssetRec.Next() = 0;


        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Asset Type", Rec.Name);
        if EmpAssetRec.FindSet() then
            repeat
                EmpAssetRec.Delete();
            until EmpAssetRec.Next() = 0;
    end;


}