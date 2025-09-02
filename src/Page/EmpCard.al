page 50128 "Employee Card Page"
{
    PageType = Card;
    SourceTable ="Employee table";
    ApplicationArea = ALL;
    Caption = 'Employee Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name";Rec."Emp. Name")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Role"; Rec.Role)
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
    var
        FilteredEnum: Enum "Employee Role";
    begin
        case Rec.Department of
            Rec.Department::IT:
                CurrPage.SetSelectionFilter(Rec);
                // This allows multiple Enum values, e.g. Developer, Tester, Support, Architect, etc.

            Rec.Department::HR:
                Rec.SetRange(Role, Rec.Role::Recruiter, Rec.Role::"Payroll Officer");

            Rec.Department::Finance:
                Rec.SetRange(Role, Rec.Role::Accountant, Rec.Role::Auditor);
        end;

        exit(false); // fallback to default dropdown behavior
        end;

                }
            }

        }

    }
}