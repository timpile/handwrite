defmodule Handwrite.Model.Letter do
  @moduledoc """
  Represents the details of a letter.
  """

  @enforce_keys [:message, :handwriting, :card]

  defstruct message: nil,
            handwriting: nil,
            card: nil,
            recipients: [],
            from: nil

  @type t() :: %__MODULE__{
          message: String.t(),
          handwriting: String.t(),
          card: String.t(),
          recipients: list(%Handwrite.Model.Recipient{}),
          from: %Handwrite.Model.From{}
        }
end
