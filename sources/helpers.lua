------------------------
--  helpers : functions collection

function math.rot2D(v,a)
    -- v : 2D vector
    -- a : angle or rotation in rads
    local s = math.sin(a)
    local c = math.cos(a)
    local x,y = v[1], v[2]
    return {x*c-y*s, x*s+y*c}
end

