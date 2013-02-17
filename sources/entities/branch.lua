-- Pakoskyfrog 2013/02/17 09:10:14

-----------------------------------------------------------
----    CBranch definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    A branch of the tree
]]

-----------------------------------------------------------
------------------------
--  Init
CBranch = {}
CBranch.__index = CBranch

------------------------
--  Properties
CBranch.type = "CBranch"


------------------------
--  Constructor
function CBranch:create(proto)
    local Branch = {}
    setmetatable(Branch, CBranch)
    
    proto = proto or {}
    print(proto.sender)
    assert(proto.sender~=nil, "CBranch : must be created on a tree")
    Branch.tree = proto.sender
    
    assert(proto.anchor~=nil, "CBranch : must be created anchored to something")
    Branch.anchor = {proto.anchor[1], proto.anchor[2]} -- relative position
    Branch.anchoredTo = proto.anchor[3] -- branches or tree
    
    Branch.attachedBy = {} -- branches
    
    Branch.lifeTime = 0
    
    Branch.orientation = 0 -- vertical... ralativelly to the anchoredTo
    
    print('Yggdrasil branch created by '..Branch.anchoredTo:getType())
    return Branch
end


------------------------
--  Callbacks

function CBranch:load()
    
end

function CBranch:draw()
    -- self draw
    do
        local x,y = self:getAbsolutePosition()
        x = x + Apps.state:getShift()
        y = Apps.state:getGroundLevel() - y
        -- TODO add wind effects
        
        local l = self:getLength()
        
        local o = self:getAbsoluteOrientation() - math.pi/2
        
        love.graphics.setColor(Apps.colors.white)
        love.graphics.setLineWidth(3)
        love.graphics.line(x,y, x+l*math.cos(o), y+l*math.sin(o))
    end
    
    -- cascade effect
    for index, b in ipairs(self.attachedBy) do
        b:draw()
    end
end

function CBranch:update(dt)
    -- self update
    self.lifeTime = self.lifeTime + dt
    
    -- cascade effect
    for index, b in ipairs(self.attachedBy) do
        b:update(dt)
    end
end

function CBranch:mousepressed(x, y, btn)
    
end

function CBranch:keypressed(key)
    
end

function CBranch:mousereleased(x, y, btn)
    
end

function CBranch:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CBranch:getType()
    return self.type
end

function CBranch:getLength()
    --------------------
    --  will calculate the length of the branch according to its age
    -- TODO non-linear growth func
    return self.lifeTime * 5
end

function CBranch:getAbsolutePosition()
    --------------------
    --  return the true position, as opposed to the relative position
    local x,y = self.anchoredTo:getAbsolutePosition()
    x = x + self.anchor[1]
    y = y + self.anchor[2]
    return x,y
end

function CBranch:getAbsoluteOrientation()
    --------------------
    --  return the true position, as opposed to the relative position
    local o = self.anchoredTo:getAbsoluteOrientation()
    o = o + self.orientation
    return o
end


print "CBranch loaded"