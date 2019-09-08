function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   return "Fermatas", "", ""
end
local fermatadef = finale.FCArticulationDef()
local metatools = finale.FCMetatoolAssignments()
metatools:SetMode(2)
metatools:LoadAll()
for metatool in each(metatools) do
   if metatool.Keystroke == 70 then
      fermatadef:Load(metatool:GetDefID())
      break
   end
end

for m, s in eachcell(finenv.Region()) do
   local cell = finale.FCCell(m, s)
   notecell = finale.FCNoteEntryCell(m, s)
   notecell:Load()
   if notecell:IsEmpty() then
      entry = notecell:AppendEntriesInLayer(1, 1)
      if entry then
         entry.Duration = finale.WHOLE_NOTE
         entry.Legality = true
         entry:MakeRest()

          notecell:Save()  --this line added
          local index = notecell:GetIndexOf(entry)  --this line added
          notecell:Load()  --this line added
          entry = notecell:GetItemAt(index)  --this line added

         local fermata = finale.FCArticulation()
         fermata:SetArticulationDef(fermatadef)
         fermata:SetNoteEntry(entry)
         fermata:SaveNew()    --this line changed

         notecell:Save()
      end
   end
end