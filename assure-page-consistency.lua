function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   return "Assure Page Consistency", "Restore Page Layout", "Makes sure every page looks like page 1"
end
    allparts = finale.FCParts()
    allparts:LoadAll()
    for onepart in each (allparts) do
        onepart:SwitchTo()
        pageone = finale.FCPage()
        pageone:Load(1)
        allpages = finale.FCPages()
        allpages:LoadAll()
        for apage in each(allpages) do
            if apage.ItemNo > 1 then
                apage.Width = pageone.Width
                apage.Height = pageone.Height
                apage.Percent = pageone.Percent
                apage.HoldMargins = pageone.HoldMargins
                apage:Save()
            end
        end
        onepart:SwitchBack()
    end