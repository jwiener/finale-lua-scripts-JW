function plugindef()
   -- This function and the 'finaleplugin' namespace
   -- are both reserved for the plug-in definition.
   return "Flip Ties", "Undo Flip Ties", "Creates a menu item to flip ties so I can assign a keyboard shortcut to it"
end

-- Load existing notes in the selection
for entry in eachentrysaved(finenv.Region()) do
    if entry:GetFlipTie() == false then
        entry:SetFlipTie(true)
    else
        entry:SetFlipTie(false)
    end
end
-- THIS FUCKING WOKRKS
