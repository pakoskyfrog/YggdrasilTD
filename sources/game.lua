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
    
    Game.camera = CGame.newCamera()
    Game.tree = CTree.create({sender=Game})
    
    return Game
end


------------------------
--  Callbacks

function CGame:load()
    
end

function CGame:draw()
    -- the BG (clouds, birds, layers, ...)
    
    -- the tree
    self.tree:draw()
    
    -- the ground
    do
        local h = self:getGroundLevel()
        if h > 0 then
            love.graphics.setColor(Apps.colors.white)
            love.graphics.setLineWidth(3)
            love.graphics.line(0,h ,Apps.w , h)
        end
    end
    
    -- the foes
    
    -- the HUD
    
end

function CGame:update(dt)
    -- controls
    self.tree:update(dt)
    
    -- foes popper
    
end

function CGame:mousepressed(x, y, btn)
    
end

function CGame:keypressed(key)
    -- temp
    if key == 'escape' then
        Actions.activateMainMenu()
    end
end

function CGame:mousereleased(x, y, btn)
    
end

function CGame:keyreleased(key)
    
end

------------------------
--  Static functions
function CGame.newCamera()
    --------------------
    --  camera factory
    local cam = {}
    -- height of the camera, -20 = ground visible at bottom screen + 20 pxl
    cam.azimuth = -20
    cam.shift   = 0
    cam.zoom    = 1
    return cam
end

------------------------
--  Member functions
function CGame:getType()
    return self.type
end

function CGame:getGroundLevel()
    --------------------
    -- always zero. this return the ground lvl on screen
    return Apps.h + self.camera.zoom * self.camera.azimuth
end

function CGame:getShift()
    --------------------
    --  horizontal panning
    return Apps.state.camera.shift*Apps.state.camera.zoom + Apps.w*0.5
end


print "CGame loaded"