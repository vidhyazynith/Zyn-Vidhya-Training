tableextension 50145 customersextension extends Item
{
    fields
    {
        field(50110; "current inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No.")));
        }
    }
}
 
