defmodule Did.PhoneRangeView do
  use Did.Web, :view

  def render("index.json", %{phone_ranges: phone_ranges}) do
    %{data: render_many(phone_ranges, Did.PhoneRangeView, "phone_range.json")}
  end

  def render("show.json", %{phone_range: phone_range}) do
    %{data: render_one(phone_range, Did.PhoneRangeView, "detail_phone_range.json")}
  end

  def render("phone_range.json", %{phone_range: phone_range}) do
    %{id: phone_range.id, start_phone: phone_range.start_phone, end_phone: phone_range.end_phone}
  end

  def render("phone_range.json", phone_range) do
    %{id: phone_range.id, start_phone: phone_range.start_phone, end_phone: phone_range.end_phone}
  end

  def render("detail_phone_range.json", %{phone_range: phone_range}) do
    %{
      id: phone_range.id, 
      start_phone: phone_range.start_phone, 
      end_phone: phone_range.end_phone,
      childs: render_many(phone_range.childs, Did.PhoneRangeView, "phone_range.json")
    }
  end

end
