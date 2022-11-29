require "fun" ()

local fca ={}
fca.context = {}

function fca.context.from_csv(fname, delim)
  delim = delim or ","
  local file = io.lines(fname)
  local ctxt = {
    objs = {},
    attrs = {},
  }
  
  -- 1st line is attribute names
  local s_iter = file():gmatch("[^" .. delim .. "]*" .. delim .. "?")
  s_iter()
  local i=1
  for s in s_iter do
    ctxt.attrs[i] = s:gsub('["' .. delim .. ']', "")
    i = i+1
  end
  
  -- the other lines
  i=1
  for s in file do
    -- 1st column
    s_iter = s:gmatch("[^" .. delim .. "]*" .. delim .. "?")
    ctxt.objs[i] = s_iter():gsub('["' .. delim .. ']', "")
    -- the other columns
    ctxt[i] = {}
    local j=1
    for s in s_iter do
      s = s:gsub('["' .. delim .. ']', "")
      if s=="false" or s=="0" or s=="no" or s=="" then
        ctxt[i][j] = false
      else
        ctxt[i][j] = true
      end
      j = j+1
    end
    i = i+1
  end
  
  return ctxt
end

local function contains(A, B) -- A contains B, i.e. B is a subset of A ?
  return foldl(
    function(acc, a, b)
      if b then return acc and a else return acc end
    end,
    true, zip(A,B) )
end

function fca.closure(ctxt, x)
  -- get the set of common attr for all the objs in x
  local attrs = totable(
    foldl(
      function(acc, obj_no)
        return map(
          function (a,b)
            return a and b
          end,
          zip(acc,ctxt[obj_no]) )
      end,
      ctxt[x[1]], x) )
    
  if not foldl( operator.lor, false, attrs ) then
    return {}
  end
  
  -- filter all objs that has the attrs
  local filtrate = filter(
    function(i, obj)
      return contains(obj, attrs)
    end,    
    enumerate(ctxt) )
  --return only indices
  return totable(
    map(
      function(i)
        return i
      end,
      filtrate) )
end

function fca.powerset(x)
  if #x == 0 then
    return { {} }
  else
    local last = x[#x]
    x[#x] = nil -- cut the last element
    local ps1 = fca.powerset(x)
    local ps2 = map(
      function(e)
        return totable ( iter(e):chain({last}) )
      end,
      ps1 )
    return totable( iter(ps1):chain(ps2) )
  end
end

function fca.build_lattice(ctxt)
  local ps = fca.powerset( totable( range(#ctxt) ) )
  table.remove(ps, 1) -- remove Empty Set
  
  local filtrate = filter(
    function(e)
      local cl = fca.closure(ctxt, e)
      return #cl > 0
    end,
    ps )
  
  local res = totable( filtrate )
  res.context = ctxt
  return res
end

return fca
