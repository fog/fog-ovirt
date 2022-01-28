module Shindo
  class Tests
    def succeeds(&block)
      test("succeeds") do
        p = block_given? ? block : proc {}
        !!instance_eval(&p)
      end
    end
  end
end
