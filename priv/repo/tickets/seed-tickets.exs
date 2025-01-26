# Seed data for some sample tickets.

require Ash.Query

for i <- 0..5 do
  ticket =
    Shire.Support.Ticket
    |> Ash.Changeset.for_create(:open, %{subject: "Issue #{i}"},
      tenant: "6b44e248-2011-465c-b52e-bf94c7baa950"
    )
    |> Ash.create!()

  if rem(i, 2) == 0 do
    ticket
    |> Ash.Changeset.for_update(:close)
    |> Ash.update!()
  else
    ticket
  end
end
