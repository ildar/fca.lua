local sets = require 'fca.sets'

describe("FCA module math sets function", function()
  it("can check subsets",
    function()
      local A,B
      A = { true,false,true }
      B = { true,false,false }
      assert.truthy(sets.contains_by_index(A,B))
      A = { true,false,false }
      B = { false,true,false }
      assert.falsy(sets.contains_by_index(A,B))
    end)

end)
  
