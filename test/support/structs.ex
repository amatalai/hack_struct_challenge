defmodule CastType do
  use StructCop

  defstruct [:integer]

  def schema, do: %{integer: :integer}
end

defmodule DefstructBeforeStructCop do
  defstruct [:test]

  use StructCop

  def schema, do: %{test: :boolean}
end

defmodule DefstructAfterStructCop do
  use StructCop

  defstruct [:test]

  def schema, do: %{test: :boolean}
end
