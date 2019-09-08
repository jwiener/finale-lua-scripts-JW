
function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   finaleplugin.Author = "Jesse Wiener"
   finaleplugin.Version = "1.0"
   finaleplugin.CategoryTags = "Chord"
   return "Chord Baseline Shift", "Undo Chord Baseline Shift", "Shifts chord baseline of selected staves (manual system selection)"
end

function shiftChordBaseline(systemNumber, staffID, amount)
	local baseline = finale.FCBaseline()
	baseline:SetMode(finale.BASELINEMODE_CHORD) -- 3 is the mode for BASELINEMODE_CHORD
	baseline:LoadForStaff(systemNumber, staffID) --loads the relevant staff baseline
	baseline.VerticalOffset = amount
	baseline:Save()
end

function calcChordBaseline(systemNumber, staffID)
	local baseline = finale.FCBaseline()
	baseline:SetMode(finale.BASELINEMODE_CHORD) -- 3 is the mode for BASELINEMODE_CHORD
	baseline:LoadForStaff(systemNumber, staffID) --loads the relevant staff baseline
	local offset = baseline.VerticalOffset
		--print (offset) --test
	return offset
end

--load selected staves
local currentSystemStaves = finale.FCSystemStaves()
currentSystemStaves:LoadAllForRegion(finenv.Region())
--switch to the page layout tool to see system numbers
local toolSwitcheroo = finenv.UI():MenuCommand(finale.MENUCMD_PAGELAYOUTTOOL)

--DIALOG 1: Prompt for System Number
	dialogSystemNumber = finenv.UserValueInput()
	dialogSystemNumber.Title = "Which System?"
	local types = {"Number"}
	dialogSystemNumber:SetTypes(types)
	local fields = {"System Number"}
	dialogSystemNumber:SetDescriptions(fields)
	systemNumberTable = dialogSystemNumber:Execute()
	systemNumber = systemNumberTable[1]
		--print (systemNumber) -- test
--END DIALOG 1

--loop through each selected staff to get its number and load it into a table
local staffNumbers = {} --create the table
local i = 0 --create the iterator
local staffID = 0 --create the variable to 

for staff in each(currentSystemStaves) do
	staffID = staff:GetStaff()
	staffNumbers[i] = staffID
		--print (staffID, systemNumber) -- test
	i = i+1
end

--DIALOG 2: Display Current Offset & Ask For New Offset--
	local currentOffset = 0
	currentOffset = calcChordBaseline(systemNumber, staffID)
	dialogOffsetAmount = finenv.UserValueInput()
	dialogOffsetAmount.Title = "How Much to Shift?"
	local types = {"Number", "Number"}
	dialogOffsetAmount:SetTypes(types)
	local fields = {"Current Vertical Offset", "New Vertical Offset"}
	dialogOffsetAmount:SetDescriptions(fields)
	dialogOffsetAmount:SetInitValues(currentOffset, "0")
	local offsetTable = dialogOffsetAmount:Execute()
	verticalOffsetAmount = offsetTable[2]
		--print (verticalOffsetAmount) -- test
--END DIALOG 2--

shiftChordBaseline(systemNumber, staffID, verticalOffsetAmount)


