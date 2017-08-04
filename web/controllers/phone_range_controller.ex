defmodule Did.PhoneRangeController do
  use Did.Web, :controller

  alias Did.PhoneRange

  def index(conn, _params) do
    phone_ranges = Repo.all(PhoneRange)
    render(conn, "index.json", phone_ranges: phone_ranges)
  end

  def create(conn, %{"phone_range" => phone_range_params}) do
    changeset = PhoneRange.changeset(%PhoneRange{}, phone_range_params)

    case Repo.insert(changeset) do
      {:ok, phone_range} ->
        phone_range_with_childs = phone_range |> Repo.preload(:childs)
        conn
        |> put_status(:created)
        |> put_resp_header("location", phone_range_path(conn, :show, phone_range))
        |> render("show.json", phone_range: phone_range_with_childs)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Did.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    phone_range = Repo.get!(PhoneRange, id) |> Repo.preload(:childs)
    render(conn, "show.json", phone_range: phone_range)
  end

  def update(conn, %{"id" => id, "phone_range" => phone_range_params}) do
    phone_range = Repo.get!(PhoneRange, id)
    changeset = PhoneRange.changeset(phone_range, phone_range_params)

    case Repo.update(changeset) do
      {:ok, phone_range} ->
        phone_range_with_childs = phone_range |> Repo.preload(:childs)
        render(conn, "show.json", phone_range: phone_range_with_childs)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Did.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    phone_range = Repo.get!(PhoneRange, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(phone_range)

    send_resp(conn, :no_content, "")
  end
end
