defmodule Did.PhoneRange do
  # use Did.Web, :model
  use Ecto.Schema
  import Ecto.Changeset
  alias Did.PhoneRange


  # phone_range is the DB table
  schema "phone_range" do
    field :start_phone, :string
    field :end_phone,:string
    has_many :childs, PhoneRange, foreign_key: :parent_phone_range_id, references: :id
    belongs_to :parent, PhoneRange, foreign_key: :parent_phone_range_id, references: :id
  end

  def changeset(phone_range, params) do
    cast(phone_range, params, [:id, :start_phone, :end_phone])
    |> cast_assoc(:childs)
    |> validate_required([:start_phone, :end_phone])
    |> validate_phone(:start_phone)
    |> validate_phone(:end_phone)
    |> validate_start_before_end
    #|> validate_childs_start_before_end
  end

  def validate_phone(changeset, field) do
    phone = get_field(changeset, field)
    case Phone.parse(phone) do
      { :ok, _ } -> changeset    
      { :error, error } -> add_error(changeset, field, Enum.join([to_string(error), "[", phone, "]"]))
    end
  end

  def validate_start_before_end(changeset) do
    case get_range_start_end(changeset) do
      {:ok, start, ends } ->
        if phone_lt_phone(start, ends) do
          changeset
        else
          changeset = add_error(changeset, :start_phone, "end_phone start before start_phone")
          changeset = add_error(changeset, :end_phone, "end_phone start before start_phone")
          changeset
        end
      {:error, msg } -> 
        changeset = add_error(changeset, :start_phone, msg)
        changeset = add_error(changeset, :end_phone, msg)
        changeset
      _ -> changeset
    end
  end

  def get_range_start_end(%PhoneRange{start_phone: start_phone, end_phone: end_phone}) do
    get_range_start_end_phones(start_phone, end_phone)
  end

  def get_range_start_end(changeset) do
    start_phone = get_field(changeset, :start_phone)
    end_phone = get_field(changeset, :end_phone)
    get_range_start_end_phones(start_phone, end_phone)
  end

  def get_range_start_end_phones(start_phone, end_phone) do
    case { Phone.parse(start_phone), Phone.parse(end_phone) } do
      {{:ok, start}, {:ok, ends }} ->
        {:ok, start, ends }
      _ -> {:error, "Unable to parse phones in phone_range" }  
    end
  end

  def phone_lt_phone(phone1, phone2) do
    if phone1.international_code <= phone2.international_code &&
       phone1.area_code <= phone2.area_code &&
       phone1.number <= phone2.number  do
      true
    else
      false
    end
  end
end
