-- Pakoskyfrog 2013/02/17 00:01:54

-----------------------------------------------------------
----    CGame definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    Game, state of apps
]]

-----------------------------------------------------------
------------------------
--  Init
CGame = {}
CGame.__index = CGame

------------------------
--  Properties
CGame.type = "CGame"
CGame.windSpeed = 0

------------------------
--  Constructor
function CGame:create()
    local Game = {}
    setmetatable(Game, CGame)
    
    
    
    return Game
end


------------------------
--  Callbacks

function CGame:load()
    
end

function CGame:draw()
    
end

function CGame:update(dt)
    
end

function CGame:mousepressed(x, y, btn)
    
end

function CGame:keypressed(key)
    
end

function CGame:mousereleased(x, y, btn)
    
end

function CGame:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CGame:getType()
    return self.type
end




print "CGame loaded"