defmodule Handwrite.From do
  @enforce_keys [:first_name, :last_name, :street1, :city, :state, :zip]

  defstruct first_name: nil,
            last_name: nil,
            street1: nil,
            street2: nil,
            city: nil,
            state: nil,
            zip: nil

  @type t() :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          street1: String.t(),
          street2: String.t() | nil,
          city: String.t(),
          state: String.t(),
          zip: String.t()
        }
end
