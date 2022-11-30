local sets = require 'fca.sets'

describe("FCA module math sets function", function()
  it("can calculate the Power Set",
    function()
      local x = {}
      local c_x = sets.powerset(x)
      assert.is_table(c_x)
      assert.is.equal(1, #c_x)
      assert.is.equal(0, #c_x[1])
      x = { 1,2,3 }
      c_x = sets.powerset(x)
      assert.is_table(c_x)
      assert.is.equal(8, #c_x)
    end)

  it("can check subsets",
    function()
      local A,B
      A = { true,false,true }
      B = { true,false,false }
      assert.truthy(sets.contains_by_index(A,B))
      A = { true,false,false }
      B = { false,true,false }
      assert.falsy(sets.contains_by_index(A,B))
      A = { 1,2,3 }
      B = { 2,3 }
      assert.truthy(sets.contains(A,B))
      A = { 1,2,3 }
      B = { 2,3,4 }
      assert.falsy(sets.contains(A,B))
    end)

end)
  
