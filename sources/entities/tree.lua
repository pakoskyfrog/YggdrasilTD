-- Pakoskyfrog 2013/02/17 09:07:47

-----------------------------------------------------------
----    CTree definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    The magnificent Yggdrasil.
    It owns a branch that owns branches that owns branches... It's the "Cascade effect"
]]

-----------------------------------------------------------
------------------------
--  Init
CTree = {}
CTree.__index = CTree

------------------------
--  Properties
CTree.type = "CTree"
CTree.growthFactor = 10
CTree.anchor = {0,0}

------------------------
--  Constructor
function CTree:create(proto)
    local Tree = {}
    setmetatable(Tree, CTree)
    
    proto = proto or {}
    Tree.parent = proto.sender or proto.parent or Apps.state or Apps
    
    Tree.iterLimit = math.max(proto.iterLimit or 5, 3)
    
    Tree.branches = CBranch:create({sender=Tree, anchor={0,0,Tree}, ori=(math.random()-0.5)*2*25})
    -- Tree.branches = CBranch:create({sender=Tree, anchor={0,0,Tree}, ori=15})
    
    Tree.towers = {} -- will contains bourgeons/buds, fruits, bugs, ...
    -- Idea : make it a weak table and insert towers on branches, inside the cascade effect
    --      : cascade effect may make it useless...
    
    print('Yggdrasil created by '..Tree.parent:getType())
    return Tree
end


------------------------
--  Callbacks

function CTree:load()
    
end

function CTree:draw()
    self.branches:draw() -- cascade drawing
    
    for index, t in ipairs(self.towers) do
        t:draw()
    end
end

function CTree:update(dt)
    self.branches:update(dt)
    
    for index, t in ipairs(self.towers) do
        t:update(dt)
    end
end

function CTree:mousepressed(x, y, btn)
    
end

function CTree:keypressed(key)
    
end

function CTree:mousereleased(x, y, btn)
    
end

function CTree:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CTree:getType()
    return self.type
end

function CTree:getMidSegment()
    ------------------------
    --  Primary mid segment
    return -20,Apps.state:getGroundLevel(), 20,Apps.state:getGroundLevel()
end
function CTree:getAbsolutePosition()
    --------------------
    --  Primary position
    return 0,0
end
function CTree:getAbsoluteOrientation()
    --------------------
    --  Primary orientation
    return -math.pi/2
end
function CTree:getLength()
    --------------------
    --  Primary length
    return 0
end
function CTree:getBaseWidth()
    --------------------
    --  Primary w-length
    return 0
end
function CTree:getTopWidth()
    --------------------
    --  Primary w-length
    return 0
end


print "CTree loaded"