function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   return "Assure System Consistency", "Restore System Sizes", "Makes sure every system looks like system 1"
end

local staffsystems = finale.FCStaffSystems()
staffsystems:LoadAll()

local systemone = finale.FCStaffSystem()
systemone:Load(1)

local staffResizePercentage = systemone:GetResize()

for currentStaffSystem in each(staffsystems) do
	if currentStaffSystem.ItemNo > 1 then
		currentStaffSystem.UseStaffResize = true
		currentStaffSystem:SetResize(staffResizePercentage)
	end
end

staffsystems:SaveAll()