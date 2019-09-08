--Settings for P/V, P/C and KEYBOARD Instruments

function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   finaleplugin.Author = "Jesse Wiener"
   finaleplugin.Version = "1.0"
   finaleplugin.Date = "09/21/2018"
   finaleplugin.CategoryTags = "Measure"
   return "Move Measure Numbers Above Staff", "Undo Move Measure Numbers Above Staff", "Moves measure numbers to the JAWLine Music standard PV/PC/Keyboard position."
end

-- ====== the constants ======
-- MNALIGN_CENTER = 1
-- MNALIGN_LEFT = 0
-- MNALIGN_RIGHT = 2

-- MNJUSTIFY_CENTER = 2
-- MNJUSTIFY_LEFT = 0
-- MNJUSTIFY_RIGHT = 1

--load all measure number regions into a collection and define a measure number region object
local measureregions = finale.FCMeasureNumberRegions()
measureregions:LoadAll()
local region = finale.FCMeasureNumberRegion()

for k=measureregions.Count,1,-1 do
    region:Load(k)
    print ("Measure Region",region.ItemNo,"Start Measure",region.StartMeasure,"End Measure",region.EndMeasure,"Start Number",region.StartNumber)
    local position = region:GetMultipleVerticalPosition(true)
    print (position)

    --disconnects score settings from part settings
    region:SetUseScoreInfoForParts(false)

  --creates a font object to be 
  --referenced when the font is set
    local fontInfo = finale.FCFontInfo()
      fontInfo.Name = "Helvetica"
      fontInfo:SetBold(false)
      fontInfo:SetItalic(false)
      fontInfo.Size = 10

    --defines system start measure numbers
    region:SetShowOnSystemStart(true,true)
    region:SetStartFontInfo(fontInfo,true)
    region:SetStartVerticalPosition(24,true)
    region:SetStartHorizontalPosition(-10,true)
    
    --defines mid-system measure numbers
    region:SetShowMultiples(true,true)
    region:SetMultipleVerticalPosition(24,true)
    region:SetMultipleHorizontalPosition(0,true)
    region:SetMultipleJustification(2,true)
    region:Save()
end