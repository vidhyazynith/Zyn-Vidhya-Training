tableextension 50112 Zyn_PostedSalesHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Beginning Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Beginning Text';
        }
        field(50101; "Ending Text"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Ending Text';
        }
        field(50103; "Begin Inv"; Text[250])
        {
            Caption = 'Begin Inv';
            DataClassification = CustomerContent;
        }
        field(50104; "End Inv"; Text[250])
        {
            Caption = 'End Inv';
            DataClassification = CustomerContent;
        }
    }
}
