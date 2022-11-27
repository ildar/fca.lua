local fca = require 'fca'

describe("FCA module importing function", function()
  it("can import animals.csv",
    function()
      local context = fca.context.from_csv("spec/animals.csv", ";")
      assert.is_table(context.attrs)
      assert.is.equal(#context.attrs, 4)
      assert.is_table(context.objs)
      assert.is.equal(#context.objs, 7)
    end)

end)
  
