-- Pakoskyfrog 2013/02/22 11:11:59

-----------------------------------------------------------
----    CHud definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    This will constitute what between the player and the game
    HUD = Head Up Display
]]

-----------------------------------------------------------
------------------------
--  Init
CHud = {}
CHud.__index = CHud

------------------------
--  Properties
CHud.type = "CHud"


------------------------
--  Constructor
function CHud:create(sender)
    local Hud = {}
    setmetatable(Hud, CHud)
    
    Hud.game = sender
    
    return Hud
end


------------------------
--  Callbacks

function CHud:load()
    
    -- infos linking
    -- works only for tables, scalars should be accessed directly
    
end

function CHud:draw()
    -- Tree life
    
    -- Wind speed/direction
    do
        local w = self.game.windSpeed
        self:drawWindSpeedBar(w)
    end
    
    
    -- calendar
    
    -- waves status
    
    -- Photosynthetic energy
    
end
function CHud:drawWindSpeedBar(ws)
    --------------------
    --  This will draw on screen a bar that indicates wind force and direction
    -- ws = wind speed : value = force, sign = direction = left/right
    local ex, ey = 200, 5
    local ox, oy = Apps.w -ex -5, Apps.h -ey -5
    
    -- BG
    love.graphics.setColor(Apps.colors.black)
    love.graphics.rectangle('fill',ox,oy, ex,ey)
    
    -- wind force : ex= 200 => -100..100  %
    local r  = ws / self.game.windMaxSpeed
    local wf = -ex*0.5* r
    local sx = math.min(ox+0.5*ex, ox+0.5*ex-wf)
    love.graphics.setColor(math.abs(r)*255,255-math.abs(r)*255,0)
    love.graphics.rectangle('fill', sx,oy, math.abs(wf),ey)
    
    -- Frame
    love.graphics.setLineWidth(1)
    love.graphics.setColor(Apps.colors.white)
    love.graphics.line(ox+0.5*ex, oy, ox+0.5*ex, oy+ey) --mid line
    love.graphics.rectangle('line',ox,oy, ex,ey)
    
end



function CHud:update(dt)
    
end

function CHud:mousepressed(x, y, btn)
    
end

function CHud:keypressed(key)
    
end

function CHud:mousereleased(x, y, btn)
    
end

function CHud:keyreleased(key)
    
end

------------------------
--  Static functions


------------------------
--  Member functions
function CHud:getType()
    return self.type
end




print "CHud loaded"