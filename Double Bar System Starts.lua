function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   finaleplugin.RequireSelection = true
   finaleplugin.Author = "Jesse Wiener"
   finaleplugin.Copyright = "2019"
   finaleplugin.Version = "1"
   finaleplugin.Date = "05/23/2019"
   finaleplugin.CategoryTags = "Measure"
   return "Double Bar System Starts", "Restore Previous Layout", "Puts All Double Bars in Selected Region at the Start of a System"
end
--This scripts checks every bar and sees if it's a doulbe bar, 
--then, if it is, it selects the NEXT bar and makes that 
--the start of a staff system

local ui = finenv.UI()
if ui:AlertYesNo("Have you unlocked the bars? (It won't work if you don't.)", 
            "Are you sure?") ~= finale.YESRETURN then
    return
end

m = finale.FCMeasure()
ms = finale.FCMeasures()
mNum = 0
measureRegion = finenv.Region()
ms:LoadRegion(measureRegion)

for m in each(ms) do
    if m.Barline == finale.BARLINE_DOUBLE then
    local mNext = ms:GetItemAt(mNum+1)
    mNext.SystemBreak = true
    local newStart = mNext:Save()
    print ("double bar in measure", m.ItemNo, "!")
    end
mNum = mNum+1

end