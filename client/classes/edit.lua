CEdit = {}
CEdit.__index = CEdit

function CEdit:create(x, y, w, h, text, parent)
    local self = setmetatable({}, self)
    self.visible = true
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.text = text
    self.parent = parent
    self.cursorpos = #text
    self.active = true
    self.color = tocolor(255, 255, 255, 255)
    self.cursorcolor = tocolor(0, 0, 0, 255)
    self.textcolor = tocolor(0, 0, 0, 255)
    if self.parent then
        self.px = x
        self.py = y
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
    end
    self.clickfunc = function(...) self:click(...) end
    self.calcfunc = function() self:calculate() end
    self.drawfunc = function() self:draw() end
    self.charfunc = function(...) self:character(...) end
    self.keyfunc = function(...) self:key(...) end
    addEventHandler("onClientClick", root, self.clickfunc)
    addEventHandler("onClientPreRender", root, self.calcfunc)
    addEventHandler("onClientRender", root, self.drawfunc)
    addEventHandler("onClientCharacter", root, self.charfunc)
    addEventHandler("onClientKey", root, self.keyfunc)
    return self
end

function CEdit:click(button, state, cx, cy)
    if self.parent then
        if self.parent.active ~= true then return end
    end
    if button ~= "left" then return end
    if state == "down" then
        if cx >= self.x and cy >= self.y and cx <= self.x+self.w and cy <= self.y+self.h then
            self.active = true
        else
            self.active = false
        end
    end
end

function CEdit:character(char)
    if self.active == false or self.parent.active == false then return end
    local beforeChar = self.cursorpos > 0 and string.sub(self.text, 0, self.cursorpos-1) or ""
    local afterChar = self.cursorpos < #self.text and string.sub(self.text, self.cursorpos, #self.text) or ""
    self.text = beforeChar..char..afterChar
    self.cursorpos = self.cursorpos+1
end

function CEdit:key(button, press)
    if self.active == false or self.parent.active == false then return end
    if press ~= false then return end
    outputChatBox("BUTTON: "..button)
    if button == "arrow_l" then
        if self.cursorpos ~= 0 then
            self.cursorpos = self.cursorpos-1
        end
    elseif button == "arrow_r" then
        if self.cursorpos ~= #self.text then
            self.cursorpos = self.cursorpos+1
        end
    end
end

function CEdit:calculate()
    if self.parent then
        self.x = self.parent.x+self.px
        self.y = self.parent.y+self.py
    end
end

function CEdit:draw()
    if self.visible ~= true then return end
    
    
    dxDrawRectangle(self.x, self.y, self.w, self.h, self.color)
    dxDrawText(self.text, self.x+5, self.y+(self.h-dxGetFontHeight(1, "default-bold")/1.75)/2, self.w, self.h, self.textcolor, 1, "default-bold")
    local cursorwidth = self.cursorpos < #self.text and dxGetTextWidth(string.sub(self.text, 0, self.cursorpos-1), 1, "defaullt-bold") or dxGetTextWidth(self.text, 1, "default-bold")
    dxDrawText("|", self.x+5+cursorwidth, self.y+(self.h-dxGetFontHeight(1, "default-bold")/1.75)/2, self.w, self.h, self.cursorcolor, 1, "default-bold")
    


end