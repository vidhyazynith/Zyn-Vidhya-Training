pageextension 50108 ContactListExt extends "Contact List"
{
    actions
    {
        addlast(processing)
        {
                action(CustomerContacts)
                {
                    Caption = 'Customer Contact';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;


                    trigger OnAction()
                    var
                        BusinessRelationEnum: Enum "Contact Business Relation";
                    begin
                        BusinessRelationEnum := BusinessRelationEnum::Customer;
                        Rec.SetRange("Contact Business Relation", BusinessRelationEnum);
                        CurrPage.Update(false);
                    end;
                }

                action(VendorContacts)
                {
                    Caption = 'Vendor Contact';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        BusinessRelationEnum: Enum "Contact Business Relation";
                    begin
                        BusinessRelationEnum := BusinessRelationEnum::Vendor;
                        Rec.SetRange("Contact Business Relation", BusinessRelationEnum);
                        CurrPage.Update(false);
                    end;
                }

                action(BankAccountContacts)
                {
                    Caption = 'Bank Account Contact';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        BusinessRelationEnum: Enum "Contact Business Relation";
                    begin
                        BusinessRelationEnum := BusinessRelationEnum::"Bank Account";
                        Rec.SetRange("Contact Business Relation", BusinessRelationEnum);
                        CurrPage.Update(false);
                    end;
                }
            
        }
    }
}
