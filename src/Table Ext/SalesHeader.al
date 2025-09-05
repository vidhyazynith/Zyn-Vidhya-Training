tableextension 50119 SalesInvoiceTableExt extends "Sales Header"
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
        //field(50105; "Last Posting Date";Date)
        // {
            // Fieldclass = FlowField;
            // CalcFormula = max("Customer Sales History"."Posting Date" Where ("Customer No" = field("Sell-to Customer No.")));
        // }
        // field(50104; "Last Sold Prize"; Decimal)         
        // {
        //     caption = 'Last sold Price' ;
        //     FieldClass = FlowField;
        //     CalcFormula = max("Customer Sales History"."Item Price" Where ("Customer No" = field("Sell-to Customer No."), "Posting Date" = field("Max Posting Date") ));
        // }

        field(50106; "From Subscription"; Boolean)
        {
            Caption = 'From Subscription';
            DataClassification = ToBeClassified;
        }
        

    }
    trigger OnAfterDelete()
    var 
            ExtTextTable: Record ExtendedTextTable;
    begin
            ExtTextTable.SetRange("Sales Document Type",rec."Document Type");
            ExtTextTable.SetRange("Document No.",rec."No.");
            if not ExtTextTable.IsEmpty then
                ExtTextTable.DeleteAll();
    end;


}