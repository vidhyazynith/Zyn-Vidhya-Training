pageextension 50100 Zyn_CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Credit Allowed"; Rec."Credit Allowed")
            {
                ApplicationArea = All;
            }
            field("Credit Used"; Rec."Credit Used")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sales Year"; Rec."Sales Year")
            {
                ApplicationArea = All;
            }
            //field("Sales Amount"; Rec."Sales Amount")
            //{
            //    ApplicationArea = All;
            //    Editable = false;
            //}
            field("Loyalty Points Allowed"; Rec."Loyalty Points Allowed")
            {
                ApplicationArea = All;
            }
            field("Loyalty Points used"; Rec."Loyalty Points Used")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addfirst(factboxes)
        {
            part("Cust Fact box"; Zyn_CustomerFactBox)
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action(VisitLog)
            {
                ApplicationArea = All;
                Caption = 'Customer Visit Log';
                Image = View;
                RunObject = page Zyn_CustomerVisitLogList;
                RunPageLink = "Customer Number" = field("No.");
            }
            action(ModifyLog)
            {
                ApplicationArea = All;
                Caption = 'Modify Visit Log';
                Image = Edit;
                RunObject = page Zyn_CustomerModifyLogList;
                RunPageLink = "Customer Number" = field("No.");
            }
            action(Problem)
            {
                ApplicationArea = All;
                Caption = 'Raise Complaint';
                Image = Create;
                trigger OnAction()
                var
                    ProblemRec: Record "Zyn_Complaint Table";
                    CustomerRec: Record Customer;
                begin
                    CustomerRec.Get(Rec."No.");
                    ProblemRec.Init();
                    ProblemRec."Customer ID" := CustomerRec."No.";
                    ProblemRec."customer Name" := CustomerRec."Name";
                    ProblemRec.Insert(true);
                    Page.Run(Page::Zyn_CompliantCard, ProblemRec);
                end;
            }
            action(SendToSlave)
            {
                Caption = 'Send To Slave Company';
                ApplicationArea = All;
                Image = SendTo;
                trigger OnAction()
                var
                    CurrentCompanyRec: Record "Zyn_Company Table";
                    SlaveCompanyRec: Record "Zyn_Company Table";
                    MirrorMgt: Codeunit "Zyn_SendFromMasterToSlaveMgt";
                begin
                    if not CurrentCompanyRec.Get(CompanyName()) then
                        exit;
                    // Ensure current is Master company
                    if (not CurrentCompanyRec."Is Master") and (CurrentCompanyRec."Master Company Name" <> '') then
                        Error('You can send customer only from a Master company.');
                    // Apply filter before opening the lookup page
                    SlaveCompanyRec.Reset();
                    SlaveCompanyRec.SetRange("Is Master", false);
                    SlaveCompanyRec.SetRange("Master Company Name", CurrentCompanyRec.Name);
                    // Open the lookup page with filtered records
                    if Page.RunModal(Page::"Zyn_Company List", SlaveCompanyRec) = Action::LookupOK then begin
                        if SlaveCompanyRec.FindSet() then begin
                            repeat
                                MirrorMgt.MirrorCustomerToSlave(Rec."No.", SlaveCompanyRec.Name);
                            until SlaveCompanyRec.Next() = 0;
                            Message('Customer %1 sent to %2 slave companies.', Rec."No.", SlaveCompanyRec.Count);
                        end else
                            Message('No slave companies were selected.');
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if rec."No." = '' then
            IsNewCustomer := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsNewCustomer and (Rec.Name = '') then begin
            Message('please enter the name of the customer');
            exit(false);
        end;
    end;

    trigger OnClosePage()
    var
        publisherMessage: Codeunit "Zyn_NewCompanyPublisher";
    begin
        if IsNewCustomer and (rec.Name <> '') then begin
            publisherMessage.NewCompanyCreated(Rec);
        end;
    end;

    procedure IsCurrentCompanyMaster(): Boolean
    var
        Comp: Record "Zyn_Company Table";
    begin
        Comp.Get(CompanyName);
        exit(Comp."Is Master");
    end;

    var
        IsNewCustomer: Boolean;
}
