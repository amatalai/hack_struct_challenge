# HackStructChallenge

## ⚠️⚠️⚠️ DON'T USE THIS ⚠️⚠️⚠️

### What is this?

This project is the result of an internal challenge in our company to hack structs
and add some automatic validation when they are created.

### How this is working?

```elixir
defmodule Foo do
  use HackStructChallenge

  defstruct [:lulz]

  def validations!(struct) do
    if struct.lulz, do: raise("for teh lulz!")

    struct
  end
end

iex()> %Foo{}
#=> %Foo{lulz: nil}

iex()> %Foo{lulz: false}
#=> %Foo{lulz: false}

iex()> %Foo{lulz: true}
# ** (RuntimeError) for teh lulz!
#     expanding struct: Foo.__struct__/1
```
