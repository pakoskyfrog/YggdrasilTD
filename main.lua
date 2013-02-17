------------------------
--  Pakoskyfrog 2013
--
-- Yggrdasil TD project
--
------------------------

math.randomseed(os.time())

------------------------
--  Dependencies
require "sources/apps"
require "sources/gui/button"
require "sources/gui/menu"
require "sources/actions"
require "sources/mainmenu"
-- require "sources/mainmenuBG"
require "sources/entities/tree"
require "sources/entities/branch"
require "sources/entities/fruit"
require "sources/entities/bug"
require "sources/entities/squirrel"
require "sources/entities/leaf"
require "sources/entities/flower"
require "sources/entities/abilities"
require "sources/entities/foe"
require "sources/game"
-- require "sources/gameBG"
require "sources/gui/hud"

------------------------
--  Löve callbacks
function love.load()
    Apps:load()
end

function love.keypressed(key)
    Apps:keypressed(key)
    
end

function love.mousepressed(x, y, button)
    Apps:mousepressed(x, y, button)
end

function love.keyreleased(key)
    Apps:keyreleased(key)
end

function love.mousereleased(x, y, button)
    Apps:mousereleased(x, y, button)
end

function love.draw()
    Apps:draw()
end

function love.update(dt)
    Apps:update(dt)
    
    -- framerate limiter
    if dt < 0.016 then  --60 FPS
        love.timer.sleep(0.016 - dt)
    end
end
