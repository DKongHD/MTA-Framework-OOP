CWindow = {}
CWindow.__index = CWindow

function CWindow:create(x, y, w, h, text)
    local self = setmetatable({}, self)
    self.visible = true
    self.color = tocolor(0, 238, 151, 200)
    self.ccolor = tocolor(0, 238, 151, 175)
    self.inactivecolor = tocolor(0, 238, 151, 160)
    self.bgcolor = tocolor(0, 0, 0, 70)
    self.textcolor = tocolor(255, 255, 255, 255)
    self.clicked = false
    self.active = true
    self.frameh = 25
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.cdis = {}
    self.text = text
    self.drawfunc = function() self:draw() end
    self.clickfunc = function(...) self:click(...) end
    self.movefunc = function(_, _, cx, cy) self:move(cx, cy) end
    addEventHandler("onClientRender", root, self.drawfunc)
    addEventHandler("onClientClick", root, self.clickfunc)
    addEventHandler("onClientCursorMove", root, self.movefunc)
    return self
end

function CWindow:click(button, state, cx, cy)
    if button ~= "left" then return end
    if cx >= self.x and cy >= self.y and cx <= self.x+self.w and cy <= self.y+self.h then
        self.active = true
        if state == "down" then
            if cx >= self.x and cy >= self.y and cx <= self.x+self.w and cy <= self.y+self.frameh then
                self.clicked = true 
                self.cdis = {cx-self.x, cy-self.y}   
            end
        elseif state == "up" then
            self.clicked = false
        end
    else
        self.active = false
    end
end

function CWindow:move(cx, cy)
    if self.clicked == true then
        self.x = cx-self.cdis[1]
        self.y = cy-self.cdis[2]   
    end
end

function CWindow:draw()
    if self.visible ~= true then return end
    local color = self.color
    if self.clicked == true then 
        color = self.ccolor
    elseif self.active == false then
        color = self.inactivecolor
    end
    dxDrawRectangle(self.x, self.y, self.w, self.frameh, color)
    dxDrawRectangle(self.x, self.y+self.frameh, self.w, self.h-self.frameh, self.bgcolor)
    dxDrawText(self.text, self.x+self.w, self.y+self.frameh, self.x, self.y, self.textcolor, 1, "default-bold", "center", "center")
end