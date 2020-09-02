defmodule Handwrite.Letter do
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
          recipients: list(%Handwrite.Recipient{}),
          from: %Handwrite.From{}
        }
end
