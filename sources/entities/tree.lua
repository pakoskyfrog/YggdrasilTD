-- Pakoskyfrog 2013/02/17 09:07:47

-----------------------------------------------------------
----    CTree definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    The magnificent Yggdrasil
]]

-----------------------------------------------------------
------------------------
--  Init
CTree = {}
CTree.__index = CTree

------------------------
--  Properties
CTree.type = "CTree"


------------------------
--  Constructor
function CTree:create(proto)
    local Tree = {}
    setmetatable(Tree, CTree)
    
    proto = proto or {}
    Tree.parent = proto.sender or proto.parent or Apps.state or Apps
    
    Tree.branches = CBranch:create({sender=Tree, anchor={0,0,Tree}})
    
    Tree.towers = {} -- will contains bourgeons, fruits, bugs, ...
    -- Idea : make it a weak table and insert towers on branches, inside the cascade effect
    
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

function CTree:getAbsolutePosition()
    --------------------
    --  Primary position
    return 0,0
end
function CTree:getAbsoluteOrientation()
    --------------------
    --  Primary orientation
    return 0
end



print "CTree loaded"