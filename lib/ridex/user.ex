defmodule Ridex.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias __MODULE__

  schema "users" do
    field :phone, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:type, :phone])
    |> validate_required([:type, :phone])
  end

  def get_or_create(phone, type) do
    case Ridex.Repo.get_by(User, phone: phone, type: type) do
      nil ->
        %__MODULE__{phone: phone, type: type}
        |> Ridex.Repo.insert()

      user ->
        {:ok, user}
    end
  end
end
