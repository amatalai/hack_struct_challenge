defmodule StructCopTest do
  use ExUnit.Case, async: true

  defmodule DefstructBeforeUsing do
    defstruct [:lulz]

    use StructCop

    def validations!(struct) do
      if struct.lulz, do: raise("for teh lulz!")

      struct
    end
  end

  defmodule DefstructAfterUsing do
    use StructCop

    defstruct [:lulz]

    def validations!(struct) do
      if struct.lulz, do: raise("for teh lulz!")

      struct
    end
  end

  describe "__using__" do
    test "works when invoked before defstruct" do
      assert %DefstructBeforeUsing{lulz: false}

      assert_raise(RuntimeError, fn ->
        ast = quote do: %DefstructBeforeUsing{lulz: true}

        Code.eval_quoted(ast, [], __ENV__)
      end)
    end

    test "works when invoked after defstruct" do
      assert %DefstructAfterUsing{lulz: false}

      assert_raise(RuntimeError, fn ->
        ast = quote do: %DefstructAfterUsing{lulz: true}

        Code.eval_quoted(ast, [], __ENV__)
      end)
    end
  end
end
