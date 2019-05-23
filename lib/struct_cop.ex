defmodule StructCop do
  defmacro __using__(_opts) do
    if struct_defined?(__CALLER__) do
      handle_defined_struct()
    else
      handle_struct_to_be_defined()
    end
  end

  defp struct_defined?(caller) do
    !!Macro.Env.vars(caller)[:struct]
  end

  defp handle_defined_struct do
    quote do
      defoverridable __struct__: 1

      def __struct__(kv) do
        struct = super(kv)
        validate(struct)
      end
    end
  end

  defp handle_struct_to_be_defined do
    quote do
      import Kernel, except: [defstruct: 1]
      import StructCop, only: [defstruct: 1]
    end
  end

  @doc false
  defmacro defstruct(kv) do
    quote do
      Kernel.defstruct(unquote(kv))

      defoverridable __struct__: 1

      def __struct__(kv) do
        struct = super(kv)
        validate(struct)
      end
    end
  end
end
