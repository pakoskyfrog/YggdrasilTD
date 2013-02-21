-- Pakoskyfrog 2013

-----------------------------------------------------------
----    CMainMenu definition
-----------------------------------------------------------

------------------------
-- Description
--[[
    First and main menu of the game.
    State of apps.
    Not much more than a few buttons in this prototype.
]]

-----------------------------------------------------------
------------------------
--  Init
CMainMenu = {}
setmetatable(CMainMenu, CMenu)

------------------------
--  Properties
CMainMenu.type = "CMainMenu"


------------------------
--  Constructor
function CMainMenu:create()
    local menu1 = CMenu.create()
    setmetatable(menu1, self)
    self.__index = self
    
    menu1:setTitle('Yggdrasil TD  '..Apps.version)
    menu1:setAlignment('center')
    
    -- PAGE 1 : main redirection page
    menu1:addBtn({caption='Proto Test', name='new', hint='Launch the settings for a new game', onClick=Actions.launchGame}) --, onClick=func , page=2
    menu1:addBtn({caption='Options', name='options', hint='Music and sounds options', onClick=Actions.wip})
    menu1:addBtn({caption='Achievements', name='achiev', hint='Displays what you have amazingly done !', onClick=Actions.wip})
    menu1:addBtn({caption='Credits', name='credits', hint='Shows the credits list', onClick=Actions.wip})
    
    return menu1
end


------------------------
--  Callbacks
function CMainMenu:load()
    --------------------
    --  once loader
    CMenu.load(self)
    
end

function CMainMenu:keypressed(key)
    if key == 'escape' then
        self:setCurrentPage(1)
    end
end


------------------------
--  Static functions


------------------------
--  Gets / Sets
function CMainMenu:getType() return self.type end



------------------------
--  Member functions




print "CMainMenu loaded"