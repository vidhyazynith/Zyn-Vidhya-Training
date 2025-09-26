tableextension 50119 Zyn_SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50101; "Beginning Text"; Text[250])
        {
            Caption = 'Beginning Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
        field(50102; "Ending Text"; Text[250])
        {
            Caption = 'Ending Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
        field(50103; "Begin Inv"; Text[250])
        {
            Caption = 'Begin Inv';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
        field(50104; "End Inv"; Text[250])
        {
            Caption = 'End Inv';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
        field(50105; "Last Sold Price"; Decimal)
        {
            Caption = 'Last Sold Price';
            DataClassification = CustomerContent;
        }
        field(50106; "From Subscription"; Boolean)
        {
            Caption = 'From Subscription';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterDelete()
    var
        ExtTextTable: Record Zyn_ExtendedTextTable;
    begin
        ExtTextTable.SetRange("Sales Document Type", rec."Document Type");
        ExtTextTable.SetRange("Document No.", rec."No.");
        if not ExtTextTable.IsEmpty then
            ExtTextTable.DeleteAll();
    end;
}