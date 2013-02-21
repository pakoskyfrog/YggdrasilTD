------------------------
--  helpers : functions collection

function math.rot2D(v,a)
    ------------------------
    -- Plannar vectorial rotation 
    --
    -- v : 2D vector
    -- a : angle or rotation in rads
    local s = math.sin(a)
    local c = math.cos(a)
    local x,y = v[1], v[2]
    return {x*c-y*s, x*s+y*c}
end

function math.iv(x, shx, shy, A, B)
    --------------------
    --  Generalized inverse function
    -- 
    -- A : global scale
    -- B : func scale
    -- shx : horiz shift
    -- shy : vert shift
    
    return A*(B/((x - shx)) + shy)
end

function math.affineFactory(x1,y1, x2,y2)
    --------------------
    --  this will return a "function" representing a line 
    -- passing by M1(x1,y1) and M2(x2,y2)
    
    local f = {}
    
    f.a = (y2-y1)/(x2-x1)
    f.b = y1-f.a*x1
    
    f.__index = f
    setmetatable(f,f)
    
    if (x2-x1) ~= 0 then
        f.__call = function (self, x)
            return self.a * x + self.b
        end
        f.__tostring = function (self)
            return 'y = '..self.a .. '*x + ' .. self.b
        end
    else
        -- vertical
        f.__call = function (self, x)
            return x1
        end
        f.__tostring = function (self)
            return 'x = ' .. x1
        end
    end
    
    return f
end

function math.intersectAffines(f1, f2)
    --------------------
    --  This will give the intersection coordinates of two affine functions
    -- f => f.a, f.b (ax+b) and f.__call (eval)
    
    local inf = math.huge
    
    -- Vertical
    if math.abs(f1.a) == inf then
        local xa = f1(0)
        return xa, f2(xa)
    end
    if math.abs(f2.a) == inf then
        local xa = f2(0)
        return xa, f1(xa)
    end
    
    -- paralellism
    if f1.a/f2.a == f1.b/f2.b then
        return false
    end
    
    local x = (f2.b-f1.b)/(f1.a-f2.a)
    local y = f1(x)
    
    return x, y
end
