-- Pakoskyfrog 2013

-----------------------------------------------------------
----    Action functions
-----------------------------------------------------------

------------------------
-- Description
--[[
    Centralisation of actions, call by buttons mostly.
]]

-----------------------------------------------------------
------------------------
--  Init
Actions = {}

function Actions.activateMainMenu()
    --------------------
    --  assigne primary state to the mainmenu
    Apps.state = CMainMenu:create()
    Apps.state:load()
end

function Actions.wip()
    --------------------
    --  Dummy function that indicates it's a work in progress
    Apps:addMsg("WIP : this is not implemented yet.")
end

function Actions:nullUnderState()
    --------------------
    --  set the underState to nil
    Apps.state.state = nil
end


function Actions:goPage1()
    --------------------
    --  Makes the menu goes back to the first page
    -- self is the button clicked
    self.parent:setCurrentPage(1)
end
