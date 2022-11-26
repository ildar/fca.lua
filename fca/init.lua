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

return fca