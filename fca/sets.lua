require "fun" ()

local sets ={}

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
