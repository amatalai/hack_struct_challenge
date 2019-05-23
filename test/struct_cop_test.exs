defmodule StructCopTest do
  use ExUnit.Case, async: true

  defmodule DefstructBeforeStructCop do
    defstruct [:lulz]

    use StructCop

    def validate(struct) do
      if struct.lulz, do: raise("for teh lulz!")

      struct
    end
  end

  defmodule DefstructAfterStructCop do
    use StructCop

    defstruct [:lulz]

    def validate(struct) do
      if struct.lulz, do: raise("for teh lulz!")

      struct
    end
  end

  test "__using__ can be invoked before defstruct" do
    assert_raise(RuntimeError, "for teh lulz!", fn ->
      ast = quote do: %DefstructBeforeStructCop{lulz: true}

      Code.eval_quoted(ast, [], __ENV__)
    end)
  end

  test "__using__ can be invoked after defstruct" do
    assert_raise(RuntimeError, "for teh lulz!", fn ->
      ast = quote do: %DefstructAfterStructCop{lulz: true}

      Code.eval_quoted(ast, [], __ENV__)
    end)
  end
end
