defmodule StructCop do
  @callback validations!(struct) :: struct | no_return

  defmacro __using__(_opts) do
    if struct_defined?(__CALLER__) do
      hack_struct()
    else
      hack_defstruct()
    end
  end

  @doc false
  defmacro defstruct(kv) do
    [
      quote do
        Kernel.defstruct(unquote(kv))
      end,
      hack_struct()
    ]
  end

  defp struct_defined?(caller) do
    !!Macro.Env.vars(caller)[:struct]
  end

  defp hack_struct do
    quote do
      @behaviour StructCop

      def validations!(changeset), do: changeset

      defoverridable __struct__: 1, validations!: 1

      def __struct__(kv) do
        struct = super(kv)
        validations!(struct)
      end
    end
  end

  defp hack_defstruct do
    quote do
      import Kernel, except: [defstruct: 1]
      import StructCop, only: [defstruct: 1]
    end
  end
end
