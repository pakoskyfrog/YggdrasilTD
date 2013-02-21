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
    assert(proto.sender~=nil, "CBranch : must be created on a tree")
    Branch.tree = proto.sender
    
    assert(proto.anchor~=nil, "CBranch : must be created anchored to something")
    Branch.anchor = {proto.anchor[1], proto.anchor[2]} -- relative position
    Branch.anchoredTo = proto.anchor[3] -- branches or tree
    
    -- Branch.iter = proto.iter or 0 -- 
    Branch.iter = (Branch.anchoredTo.iter or -1) +1 -- 
    
    Branch.attachedBy = {} -- branches
    
    Branch.lifeTime = 0
    Branch.ttne = 15 -- Time To Next Evolution (sec)
    
    Branch.orientation = math.rad(proto.ori) or 0 -- 0 is same direction than the anchoredTo
    
    -- print('Yggdrasil branch created by '..Branch.anchoredTo:getType(), proto.anchor[1]*100, proto.anchor[2]*100, proto.ori..'deg', Branch:getAbsolutePosition())
    return Branch
end


------------------------
--  Callbacks

function CBranch:load()
    
end

function CBranch:draw()
    -- cascade effect
    for index, b in ipairs(self.attachedBy) do
        b:draw()
    end
    
    -- self draw
    do
        local x,y = self:getAbsolutePosition()
        -- print(self.iter,x,y)
        x = x + Apps.state:getShift()
        y = Apps.state:getGroundLevel() - y
        -- TODO add wind effects
        
        local l = self:getLength()
        local tw = self:getTopWidth()
        local bw = self:getBaseWidth()
        local o = self:getAbsoluteOrientation()-- - math.pi/2
        
        -- central line, should be tmp...
        -- love.graphics.setColor(Apps.colors.white)
        -- love.graphics.setLineWidth(3)
        -- love.graphics.line(x,y, x+l*math.cos(o), y+l*math.sin(o))
        
        local pts = {}
        -- top
        do
            pts[1] = x+l*math.cos(o) - 0.5*tw*math.sin(o)
            pts[2] = y+l*math.sin(o) + 0.5*tw*math.cos(o)
            pts[3] = x+l*math.cos(o) + 0.5*tw*math.sin(o)
            pts[4] = y+l*math.sin(o) - 0.5*tw*math.cos(o)
        end
        -- base
        do
            pts[7] = x - 0.5*bw*math.sin(o)
            pts[8] = y + 0.5*bw*math.cos(o)
            pts[5] = x + 0.5*bw*math.sin(o)
            pts[6] = y - 0.5*bw*math.cos(o)
        end
        
        -- love.graphics.setColor(Apps.colors.green)
        love.graphics.setColor(self:getColor())
        
        love.graphics.polygon('fill', pts)
        love.graphics.setLineWidth(3)
        love.graphics.setColor(Apps.colors.white)
        -- love.graphics.polygon('line', pts)
        pts[9]=pts[1]
        pts[10]=pts[2]
        love.graphics.line(pts)
    end
    
end

function CBranch:update(dt)
    -- cascade effect
    for index, b in ipairs(self.attachedBy) do
        b:update(dt)
    end
    
    -- self update
    self.lifeTime = self.lifeTime + dt*self.tree.growthFactor
    
    -- check if i get a new branch or a new tower emplacement (bud/bourgeon) TODO
    if self.lifeTime > self.ttne then self:evolve() end
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

function CBranch:getColor()
    --------------------
    --  this will give a color according to the size and teh age of the branch
    local l = self:getLength()
    local t = self.lifeTime
    local r = math.iv(t+l, -80, -255, -1, 20000)*0.5
    local v = math.iv(t+l, -150, 85, 1, 25000)
    local b = r*0.33333
    return {r, v, b}
end


function CBranch:getLength()
    --------------------
    --  will calculate the length of the branch according to its age
    -- need math.iv in helpers
    local t = self.lifeTime -- in sec
    local it = 1/(self.iter+1)
    local shx = -12.5
    local shy = -400*it
    local A = -1
    local B = 5000*it
    return math.iv(t, shx, shy, A, B)
end

function CBranch:getTopWidth()
    --------------------
    --  will calculate the length of the branch according to its age
    local t = self.lifeTime -- in sec
    local it = 1/(self.iter+1)
    local shx = -32.5
    local shy = -80*it
    local A = -1
    local B = 5000*it
    return math.max(0, math.iv(t, shx, shy, A, B))
end

function CBranch:getBaseWidth()
    --------------------
    --  will calculate the length of the branch according to its age
    local t = self.lifeTime -- in sec
    local it = 1/(self.iter+1)
    local shx = -33.333333333333
    local shy = -150*it
    local A = -1
    local B = 5000*it
    return math.iv(t, shx, shy, A, B)
end

function CBranch:getAbsolutePosition(disp)
    --------------------
    --  return the true position, as opposed to the relative position
    local a   = self.anchoredTo
    local x,y = a:getAbsolutePosition()
    local o   = a:getAbsoluteOrientation() - self.tree:getAbsoluteOrientation()
    local l   = a:getLength()
    local w   = a:getBaseWidth()
    local dv  = math.rot2D({self.anchor[1]*w, self.anchor[2]*l}, -o)
    if disp then
        print('x,y',x,y)
        print('o',math.deg(o))
        print('l',l)
        print('w',w)
        print("ax="..self.anchor[1], "ay="..self.anchor[2])
        print("dx="..self.anchor[1]*w, "dy="..self.anchor[2]*l)
        print("drx="..dv[1], "dry="..dv[2])
    end
    x = x + dv[1]
    y = y + dv[2]
    return x,y
end

function CBranch:getAbsoluteOrientation()
    --------------------
    --  return the true position, as opposed to the relative position
    local o = self.anchoredTo:getAbsoluteOrientation()
    o = o + self.orientation
    return o
end

function CBranch:evolve()
    --------------------
    --  this will make the branch to grow an other branch or a bud (bourgeon)
    
    -- print("can't evolve yet, not implemented / WIP")
    
    -- self.tree.growthFactor = 0.5
    self:addBranch()
    
    -- print('infos : ', self:getLength(), self:getBaseWidth())
    
    -- self.ttne = self.ttne + (15+5*self.iter)
    
     --20% increase + 30% random
    self.ttne = self.ttne * (1.2 + math.random()*0.3) 
    
    -- with ttne_0 = 15 sec
    -- {15, 18., 21.6, 25.92, 31.104, 37.3248} + random
    return false
end

function CBranch:addBranch()
    --------------------
    --  will add a branch somewhere
    
    -- Limit reached ?
    if self.tree.iterLimit <= self.iter then
        return
    end
    
    -- 1st model : 100% ramdom positionning
    do
        -- local sens = 1
        -- if math.random() > 0.5 then
            -- sens = -1
        -- end
        
        -- -- it's %ages
        -- local ax, ay = sens*0.4, math.random()
        -- local o = sens*(90-((math.random())*30+25))
        
        -- -- local b = CBranch:create({sender=self.tree, anchor={ax,ay,self}, ori=o})
        -- -- local b = CBranch:create({sender=self.tree, anchor={ax,0.8,self}, ori=30*sens})
        -- local b = CBranch:create({sender=self.tree, anchor={ax,ay,self}, ori=o})
        -- table.insert(self.attachedBy, b)
    end
    
    -- 2nd model : top 33%, 1 branch left, 1 right, 1 top
    do
        -- full ?
        if self.gotLeft and self.gotMid and self.gotRight then return end
    
        local rs = math.random()
        local sens = -1
        if rs > 0.333 then sens = 0 end
        if rs > 0.666 then sens = 1 end
        
        -- you can not evolve if you already have your branch
        if sens == -1 and self.gotLeft  then return end
        if sens ==  0 and self.gotMid   then return end
        if sens ==  1 and self.gotRight then return end
        
        -- positionning
        -- it's %ages
        -- TODO : make the orientation angle to prefenreciably goes up, o=f(op)
        local ax, ay = sens*0.4, math.random()/3 + 0.66
        local o = sens*90-sens*((math.random())*30+25)
        if sens == 0 then o = (math.random()-0.5)*2*30 end
        
        -- DEBUG
        -- if sens == -1 then print('left  ADD',o) end
        -- if sens ==  0 then print('mid   ADD',o) end
        -- if sens ==  1 then print('right ADD',o) end
        
        -- register the new branch
        if sens == -1 then self.gotLeft  = true end
        if sens ==  0 then self.gotMid   = true end
        if sens ==  1 then self.gotRight = true end
        
        local b = CBranch:create({sender=self.tree, anchor={ax,ay,self}, ori=o})
        table.insert(self.attachedBy, b)
    end
end



print "CBranch loaded"