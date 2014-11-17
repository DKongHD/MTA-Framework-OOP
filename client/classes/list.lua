CList = {}
CList.__index = CList

function CList:create()
    local self = setmetatable({}, self)
    
    return self
end