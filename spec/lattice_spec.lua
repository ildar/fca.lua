local fca = require 'fca'

describe("FCA module lattice function", function()
  it("can build a lattice",
    function()
      local context = fca.context.from_csv("spec/animals.csv", ";")
      local lattice = fca.build_lattice(context)
      assert.is_table(lattice)
      assert.is_not.equal(math.pow(2, #context), #lattice)
    end)

end)
  
