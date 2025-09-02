// Page Extension for Posted Sales Invoice
pageextension 50111 "PostedSalesInvoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group("Invoice Texts")
            {
                field("Beginning Text"; Rec."Beginning Text") // Add field in table extension too
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Beginning inv"; Rec."begin Inv") // Add field in table extension too
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ending inv"; Rec."End Inv")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Invoice Texts")
        {
            part("Posted Begin Invoice"; "Posted Beginning Text ListPart") // your custom listpart
            {
                Caption= 'Begin Text';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."),Type = const(Beginning);
            }

            part("Posted End Invoice"; "Posted Ending Text ListPart") // your custom listpart
            {
                Caption = 'End Text';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."),Type = const(ending);
            }


        }
    }
}
