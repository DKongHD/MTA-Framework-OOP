sx, sy = guiGetScreenSize()
utils = utils or {}

utils.isOver = function(cx, cy, x, y, w, h)
    if cx >= x and cy >= y and cx <= x+w and cy <= y+h then
        return true
    else
        return false
    end
end

utils.mouseOver = function(x, y, w, h)
    local cx, cy = getCursorPosition()
    if not cx then return false end
    cx = cx*sx
    cy = sy*cy
    return utils.isOver(cx, cy, x, y, w, h)
end

