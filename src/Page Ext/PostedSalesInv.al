pageextension 50111 Zyn_PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group("Invoice Texts")
            {
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Beginning inv"; Rec."begin Inv")
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
            part("Posted Begin Invoice"; Zyn_PostedBeginTextListPart)
            {
                Caption = 'Begin Text';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }
            part("Posted End Invoice"; Zyn_PostedEndingTextListPart)
            {
                Caption = 'End Text';
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(ending);
            }
        }
    }
}
