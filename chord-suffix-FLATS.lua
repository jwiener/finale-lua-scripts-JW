--this is meant to just isolate numbers and other relavent symbols
--correct the b==flat thing BEFORE you reposition

for i = 1,1000,1 do -- assuming that there are less than 1000 chord suffix definitions
     local cse=finale.FCChordSuffixElements()
     cse:LoadAllForItem(i)
     if cse.Count>0 then
        for c in each(cse) do
            print ("Num: ", c.NumberRepresentation, "/ ", "Symbol:", c.Symbol, "/ ", "Vertical Offset:", c.VerticalOffset)
            
                   --if it's an "b"
            if (c.Symbol == 98) then
                local fontInfo = finale.FCFontInfo()
                    fontInfo.Name = "Maestro"
                    fontInfo.Size = 22
                c:SetFontInfo(fontInfo)
                c.VerticalOffset = 40
--shift it over by 8
                local currentSpot = c.HorizontalOffset
                local newSpot = currentSpot + 8
                c.HorizontalOffset = newSpot
                c:Save()
        end
    end
end
end