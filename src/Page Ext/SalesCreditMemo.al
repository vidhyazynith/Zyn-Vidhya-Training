pageextension 50112 "SalesCreditMemoExt" extends "Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            group("Credit Memo Texts")
            {
                field("Beginning Text"; Rec."Beginning Text") // Add field in table extension too
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
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type);
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
        }
        addafter("Credit Memo Texts")
        {
            part("Beginning Text Lines"; Zyn_BeginningTextCreditMemo) // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }

            part("Ending Text ListPart"; Zyn_EndingTextCreditMemo) // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }

        }

    }
}
