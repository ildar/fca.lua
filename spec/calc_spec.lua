local fca = require 'fca'

describe("FCA module calculating functions", function()
  local context
  setup(function()
      context = fca.context.from_csv("spec/animals.csv", ";")
    end)
  
  it("can do closures",
    function()
      local x = { 1 }
      local c_x = fca.closure(context, x)
      assert.is_table(c_x)
      assert.is.equal(1, #c_x)
      assert.is.equal(c_x[1], x[1])
      x = { 6 }
      c_x = fca.closure(context, x)
      assert.is_table(c_x)
      assert.is.equal(4, #c_x)
      assert.is_not.equal(c_x[1], x[1])
    end)

  it("can calculate the Power Set",
    function()
      local x = {}
      local c_x = fca.powerset(x)
      assert.is_table(c_x)
      assert.is.equal(1, #c_x)
      assert.is.equal(0, #c_x[1])
      x = { 1,2,3 }
      c_x = fca.powerset(x)
      assert.is_table(c_x)
      assert.is.equal(8, #c_x)
    end)

end)
  
