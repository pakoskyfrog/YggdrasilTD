-- Pakoskyfrog 2013/02/17 00:01:54

-----------------------------------------------------------
----    CGame definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    Game, state of apps.
    Will encapsulate main entities, the tree, foes, environment, ...
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
    
    --TMP
    love.graphics.setColor(Apps.colors.white)
    love.graphics.setFont(Apps.fonts.tiny)
    love.graphics.print('Mid button to move around', 2, 2)
    love.graphics.print('Current Growth rate = '.. self.tree.growthFactor ..'x', 2, 22)
    love.graphics.print('Escape to return to main menu', 2, 42)
end

function CGame:update(dt)
    -- controls
    self.tree:update(dt)
    
    -- camera
    self:updateCamPos()
    
    -- foes popper
    
end

function CGame:mousepressed(x, y, btn)
    if btn == 'm' then
        self.grab = true
        self.grabOrig = {love.mouse.getPosition()}
    end
end

function CGame:keypressed(key)
    -- temp
    if key == 'escape' then
        Actions.activateMainMenu()
    end
end

function CGame:mousereleased(x, y, btn)
    if btn == 'm' then
        self.grab = nil
        self.grabOrig = nil
    end
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

function CGame:updateCamPos()
    --------------------
    --  This will move the camera if the mouse / user ...
    if self.grab then
        local ox, oy = unpack(self.grabOrig)
        local x,  y  = love.mouse.getPosition()
        local dx, dy = x-ox, y-oy
        
        self.camera.azimuth = self.camera.azimuth + dy
        self.camera.shift   = self.camera.shift   + dx
        
        self.grabOrig = {love.mouse.getPosition()}
    end
end


print "CGame loaded"