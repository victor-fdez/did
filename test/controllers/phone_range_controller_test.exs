defmodule Did.PhoneRangeControllerTest do
  use Did.ConnCase

  alias Did.PhoneRange
  @valid_attrs %{
    "id" => 1,
    "start_phone" => "+19154710552",
    "end_phone" => "+19154710553",
  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, phone_range_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    phone_data = %PhoneRange{start_phone: "+19154712323", end_phone: "+19154712324"}
    phone_range = Repo.insert! phone_data
    conn = get conn, phone_range_path(conn, :show, phone_range)
    assert json_response(conn, 200)["data"] 
      == 
        %{
          "id" => phone_range.id, 
          "start_phone" => phone_data.start_phone, 
          "end_phone" => phone_data.end_phone,
          "childs" => []
        }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, phone_range_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, phone_range_path(conn, :create), phone_range: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PhoneRange, id: json_response(conn, 201)["data"]["id"])
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, phone_range_path(conn, :create), phone_range: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    phone_range = Repo.insert! %PhoneRange{}
    conn = put conn, phone_range_path(conn, :update, phone_range), phone_range: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PhoneRange, id: json_response(conn, 200)["data"]["id"])
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    phone_range = Repo.insert! %PhoneRange{}
    conn = put conn, phone_range_path(conn, :update, phone_range), phone_range: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    phone_range = Repo.insert! %PhoneRange{}
    conn = delete conn, phone_range_path(conn, :delete, phone_range)
    assert response(conn, 204)
    refute Repo.get(PhoneRange, phone_range.id)
  end
end
