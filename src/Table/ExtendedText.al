table 50103 Zyn_ExtendedTextTable
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(50100; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(50101; "Text"; Text[100])
        {
            Caption = 'Text';
            DataClassification = CustomerContent;
        }
        field(50102; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(50103; "Sales Document Type"; enum "Sales Document Type")
        {
            Caption = 'Sales Document Type';
            DataClassification = CustomerContent;
        }
        field(50104; "Type"; enum "Zyn_Sales Invoice Text")
        {
            Caption = 'Text Type';
            DataClassification = CustomerContent;
        }
        field(50105; "Code"; Code[100])
        {
            Caption = 'code';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Line No.", "Document No.", text, "Language Code", "Type")
        {
            Clustered = true;
        }
    }
}