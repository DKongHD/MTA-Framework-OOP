CLabel = {}
CLabel.__index = CLabel

function CLabel:create(x, y, text, size, parent)
    local self = setmetatable({}, self)
    self.visible = true
    self.x = x
    self.y = y
    self.text = text
    self.size = size or 1
    self.parent = parent
    self.textcolor = tocolor(255, 255, 255, 255)
    if self.parent then
        self.px = x
        self.py = y
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
    end
    self.calcfunc = function() self:calculate() end
    self.drawfunc = function() self:draw() end
    addEventHandler("onClientPreRender", root, self.calcfunc)
    addEventHandler("onClientRender", root, self.drawfunc)
    return self
end

function CLabel:calculate()
    if self.parent then
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
    end
end

function CLabel:draw()
    if self.visible ~= true then return end
    dxDrawText(self.text, self.x, self.y, self.x, self.y, self.textcolor, self.size, "default-bold")
end