require "fun" ()

local sets ={}

function sets.powerset(x)
  if #x == 0 then
    return { {} }
  else
    local last = x[#x]
    x[#x] = nil -- cut the last element
    local ps1 = sets.powerset(x)
    local ps2 = map(
      function(e)
        return totable ( iter(e):chain({last}) )
      end,
      ps1 )
    return totable( iter(ps1):chain(ps2) )
  end
end

function sets.contains_by_index(A, B) -- A contains B, i.e. B is a subset of A ?
  return foldl(
    function(acc, a, b)
      if b then return acc and a else return acc end
    end,
    true, zip(A,B) )
end

function sets.contains(A, B) -- A contains B, i.e. B is a subset of A ?
  return foldl(
    function(acc, b)
      return acc and foldl(
        function(acc, a)
          if a==b then
            return true
          else
            return acc
          end
        end,
        false, A)
    end,
    true, B )
end

return sets
