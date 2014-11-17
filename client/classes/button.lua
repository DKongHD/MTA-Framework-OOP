CButton = {}
CButton.__index = CButton

function CButton:create(x, y, w, h, text, func, parent)
    local self = setmetatable({}, self)
    self.visible = true
    self.color = tocolor(0, 238, 151, 160)
    self.mcolor = tocolor(0, 238, 151, 220)
    self.ccolor = tocolor(0, 238, 151, 175)
    self.textcolor = tocolor(255, 255, 255, 255)
    self.mover = false
    self.clicked = false
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.text = text
    self.func = func
    self.parent = parent
    if self.parent then
        self.px = x
        self.py = y
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
    end
    self.calcfunc = function() self:calculate() end
    self.drawfunc = function() self:draw() end
    self.clickfunc = function(...) self:click(...) end
    addEventHandler("onClientPreRender", root, self.calcfunc)
    addEventHandler("onClientRender", root, self.drawfunc)
    addEventHandler("onClientClick", root, self.clickfunc)
    return self
end

function CButton:click(button, state, cx, cy)
    if self.parent then
        if self.parent.active == false then
            return
        end
    end
    if button ~= "left" then return end
    if state == "down" then
        if utils.isOver(cx, cy, self.x, self.y, self.w, self.h) then
            self.clicked = true
            self.func()
            --Execute the clickhandler func--
        end
    elseif state == "up" then
        --if utils.isOver(cx, cy, self.x, self.y, self.w, self.h) then
        self.clicked = false
            -- end
    end
end

function CButton:calculate()
    if self.parent then
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
        if self.parent.active ~= true then
            self.mover = false
            self.clicked = false
            return
        end
    end
    if utils.mouseOver(self.x, self.y, self.w, self.h) then
        self.mover = true
    else
        self.mover = false
    end
end

function CButton:draw()
    if self.visible ~= true then return end
    local color = self.color
    if self.clicked then
        color = self.ccolor
    elseif self.mover then
        color = self.mcolor
    end
    dxDrawRectangle(self.x, self.y, self.w, self.h, color)
    dxDrawText(self.text, self.x+self.w, self.y+self.h, self.x, self.y, self.textcolor, 1, "default-bold", "center", "center")
end



