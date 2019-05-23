defmodule StructCopTest do
  use ExUnit.Case, async: true

  defmodule DefstructBeforeStructCop do
    defstruct [:test]

    use StructCop

    def schema, do: %{test: :integer}
  end

  defmodule DefstructAfterStructCop do
    use StructCop

    defstruct [:test]

    def schema, do: %{test: :boolean}
  end

  test "__using__ can be invoked before defstruct" do
    assert_raise(ArgumentError, fn ->
      ast = quote do: %DefstructBeforeStructCop{test: "invalid"}

      Code.eval_quoted(ast, [], __ENV__)
    end)
  end

  test "__using__ can be invoked after defstruct" do
    assert_raise(ArgumentError, fn ->
      ast = quote do: %DefstructAfterStructCop{test: "invalid"}

      Code.eval_quoted(ast, [], __ENV__)
    end)
  end
end
