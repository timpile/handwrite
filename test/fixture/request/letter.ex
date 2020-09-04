defmodule Fixture.Request.Letter do
  def build do
    %Handwrite.Model.Letter{
      message: "Hi John,\r\n\r\nThanks for everything!\r\n\r\nYour buddy,\r\nTim",
      handwriting: "5dc306b0bc08d20016f1ec34",
      card: "5ee796dedb3dce23d4c19edf",
      recipients: [
        %Handwrite.Model.Recipient{
          first_name: "John",
          last_name: "M.",
          street1: "543 Market St",
          city: "San Francisco",
          state: "CA",
          zip: "54321"
        }
      ],
      from: %Handwrite.Model.From{
        first_name: "Tim",
        last_name: "P",
        street1: "123 6 Mile",
        street2: "",
        city: "Detroit",
        state: "MI",
        zip: "12345"
      }
    }
  end
end
