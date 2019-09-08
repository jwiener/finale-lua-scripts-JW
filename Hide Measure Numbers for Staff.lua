function plugindef()
    finaleplugin.Author = "Jesse Wiener"
    finaleplugin.Version = "1.0"
    finaleplugin.Date = "September 7, 2018"
    -- finaleplugin.RequireSelection = true -- not sure
    finaleplugin.CategoryTags = "hide measure numbers"
    return "Hide Measure Numbers", "Hide Measure Numbers", "Hide Measure Numbers on Selected Staves"
end

-- get list of staves selected, stolen and modified from stackoverflow code by vogomatix
local stavesSelected = {}
local hash = {}
local uniqueList = {}

i = 1
for m, s in eachcell(finenv.Region()) do
   stavesSelected[i] = s
   i = i + 1
end

-- this will make so there are no repetitions of the same staff number
for _,v in ipairs(stavesSelected) do
   if (not hash[v]) then
       uniqueList[#uniqueList+1] = v 
       hash[v] = true
   end
end

for k, v in ipairs(uniqueList) do
  if (v > 0) then -- 0 indicates no staves selected
    local staff = finale.FCStaff()
    staff:Load(v)
    staff.ShowMeasureNumbers = false
    staff:Save()
  end
end
