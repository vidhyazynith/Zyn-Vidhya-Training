pageextension 50109 Zyn_SalesInvoiceCardExt extends "Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group("Invoice Texts")
            {
                Caption = 'Invoice Texts';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Zyn_Extended Text Handler";
                        Type: Enum "Zyn_Sales Invoice Text";
                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type)
                    end;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Zyn_Extended Text Handler";
                        Type: Enum "Zyn_Sales Invoice Text";
                    begin
                        Type := Type::Ending;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Ending Text", Type);
                    end;
                }
            }
            group(CheckCreation)
            {
                Caption = 'Check Creation';
                field("From Subscription"; Rec."From Subscription")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Invoice Texts")
        {
            part("Beginning ListPart"; Zyn_BeginningTextListpart)
            {
                ApplicationArea = All;
                Caption = 'Beginning';
                SubPageLink = "Document No." = field("No."), Type = const(Beginning);
            }
            part("Ending ListPart"; Zyn_EndingTextListPart)
            {
                ApplicationArea = All;
                Caption = 'Ending';
                SubPageLink = "Document No." = field("No."), Type = const(Ending);
            }
        }
    }
}