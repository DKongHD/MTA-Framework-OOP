CFramework = {}
CFramework.__index = CFramework

function CFramework:create()
    local self = setmetatable({}, self)
    
    self.button = CButton
    self.checkbox = CCheckbox
    self.edit = CEdit
    self.list = CList
    self.label = CLabel
    self.window = CWindow

	--load the main framework--
	--load the classes--
    return self
end

--just for testing the framework--
--just examples of how to use the framework--
local framework = CFramework:create()

local window = framework.window:create(200, 200, 250, 500, "a small window")
local button = framework.button:create(25, 50, 200, 50, "LOOOOL", function() outputChatBox("clicked") end, window)
local label = framework.label:create(50, 200, "It's a label", 1, window)
local checkbox = framework.checkbox:create(50, 300, "It's a box", window)
local edit = framework.edit:create(25, 400, 200, 30, "LOOOOOL", window)

function chgBtnColor()

    local r, g, b = math.random(1, 255), math.random(1, 255), math.random(1, 255)
    button.color = tocolor(r, g, b, 160)
    button.mcolor = tocolor(r, g, b, 220)
    button.ccolor = tocolor(r, g, b, 175)

end

addCommandHandler("chgb", chgBtnColor)