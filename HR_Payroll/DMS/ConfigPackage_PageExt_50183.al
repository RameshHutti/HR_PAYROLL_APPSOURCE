pageextension 60547 ConfigPack1 extends "Config. Packages"
{
    layout
    {
        modify(Code)
        {
            Width = 22;
        }
    }

    actions
    {
        addafter("F&unctions")
        {
            group(Import)
            {
                action("DMS Universal Import")
                {
                    ApplicationArea = All;
                    Image = Import;
                    trigger OnAction()
                    Var
                        DMSXmlport: XmlPort "DMS Universal XMLport";
                    begin
                        DMSXmlport.Run();
                    end;
                }
            }
        }
    }
}