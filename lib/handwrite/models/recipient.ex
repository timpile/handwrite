defmodule Handwrite.Model.Recipient do
  @moduledoc """
  Represents the name and address of the person receiving the card.
  """

  @enforce_keys [:first_name, :last_name, :street1, :city, :state, :zip]

  defstruct first_name: nil,
            last_name: nil,
            street1: nil,
            city: nil,
            state: nil,
            zip: nil

  @type t() :: %__MODULE__{
          first_name: String.t(),
          last_name: String.t(),
          street1: String.t(),
          city: String.t(),
          state: String.t(),
          zip: String.t()
        }
end
