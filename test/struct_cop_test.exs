defmodule StructCopTest do
  use ExUnit.Case, async: true

  describe "casts types correctly" do
    test "when building struct directly" do
      assert %CastType{integer: 1} == %CastType{integer: "1"}
    end

    test "when using struct! function" do
      assert struct!(CastType, integer: 1) == struct!(CastType, integer: "1")
    end
  end

  describe "__using__" do
    test "works when invoked before defstruct" do
      assert_raise(ArgumentError, fn ->
        ast = quote do: %DefstructBeforeStructCop{test: "invalid"}

        Code.eval_quoted(ast, [], __ENV__)
      end)
    end

    test "works when invoked after defstruct" do
      assert_raise(ArgumentError, fn ->
        ast = quote do: %DefstructAfterStructCop{test: "invalid"}

        Code.eval_quoted(ast, [], __ENV__)
      end)
    end
  end
end
