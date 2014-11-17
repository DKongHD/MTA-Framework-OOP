CCheckbox = {}
CCheckbox.__index = CCheckbox

function CCheckbox:create(x, y, text, parent)
    local self = setmetatable({}, self)
    self.visible = true
    self.x = x
    self.y = y
    self.text = text
    self.parent = parent
    self.checked = false
    self.clicked = false
    self.color = tocolor(0, 238, 151, 255)
    self.ccolor = tocolor(0, 238, 151, 220)
    self.textcolor = tocolor(255, 255, 255, 255)
    if self.parent then
        self.px = x
        self.py = y
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
    end
    self.chars = {[true] = 9745, [false] = 9744}
    self.clickfunc = function(...) self:click(...) end
    self.calcfunc = function() self:calculate() end
    self.drawfunc = function() self:draw() end
    addEventHandler("onClientClick", root, self.clickfunc)
    addEventHandler("onClientPreRender", root, self.calcfunc)
    addEventHandler("onClientRender", root, self.drawfunc)
    return self
end

function CCheckbox:click(button, state, cx, cy)
    if self.parent then
        if self.parent.active == false then
            return
        end
    end
    if button ~= "left" then return end
    if state == "down" then
        local fullwidth = dxGetTextWidth(utfChar(self.chars[self.checked])..self.text, 1.2, "default-bold")
        local height = dxGetFontHeight(1.2, "default-bold")/1.75
        if cx >= self.x and cy >= self.y and cx <= self.x+fullwidth and cy <= self.y+height then
            self.checked = not self.checked
            self.clicked = true
        end
    else
        self.clicked = false
    end
end

function CCheckbox:calculate()
    if self.parent then
       self.x = self.parent.x+self.px
       self.y = self.parent.y+self.py
    end
end

function CCheckbox:draw()
    if self.visible ~= true then return end
    local boxtext = utfChar(self.chars[self.checked])
    local boxwidth = dxGetTextWidth(boxtext, 1.2, "default-bold")
    dxDrawText(boxtext, self.x, self.y-1, self.x, self.y, self.clicked == true and self.ccolor or self.color, 1.2, "default-bold")
    dxDrawText(self.text, self.x+boxwidth, self.y, self.x+boxwidth, self.y, self.textcolor, 1.2, "default-bold")
end