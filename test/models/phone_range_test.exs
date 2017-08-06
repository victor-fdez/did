require IEx
defmodule Did.PhoneRangeTest do
  use Did.ModelCase
  import Did.ModelCase.Macros

  alias Did.PhoneRange

  @phone_range_tests %{
    0 => %{
      test_msg: "valid start and end phone range",
      phone_attrs: %{start_phone: "+1 915 449 44 34", end_phone: "+1 915 449 44 38"},
      valid: true
    },
    1 => %{
      test_msg: "invalid start and end phone range",
      phone_attrs: %{start_phone: "+1 915 449 44 40", end_phone: "+1 915 449 44 38"},
      valid: false 
    },
    2 => %{
      test_msg: "valid start_phone area code before end_phone",
      phone_attrs: %{start_phone: "+1 404 449 44 38", end_phone: "+1 915 449 44 38"},
      valid: true
    },
    3 => %{
      test_msg: "invalid start_phone area code after end_phone",
      phone_attrs: %{start_phone: "+1 915 449 44 38", end_phone: "+1 914 449 44 38"},
      valid: false 
    },
    4 => %{
      test_msg: "phone range can't have not attributes",
      phone_attrs: %{},
      valid: false 
    },
    5 => %{
      test_msg: "phone attributes can have numbers without spaces",
      phone_attrs: %{start_phone: "+19154710553", end_phone: "+19154710554"},
      valid: true 
    }
  }
  
  phone_range_test @phone_range_tests[0]
  phone_range_test @phone_range_tests[1]
  phone_range_test @phone_range_tests[2]
  phone_range_test @phone_range_tests[3]
  phone_range_test @phone_range_tests[4]
  phone_range_test @phone_range_tests[5]

  test "check childs are added when formatted correctly" do
    changeset = PhoneRange.changeset(%PhoneRange{}, %{
      start_phone: "+19154710553", end_phone: "+19154710554",
      childs: [
        %{ start_phone: "+19154710553", end_phone: "+19154710553" },
        %{ start_phone: "+19154710554", end_phone: "+19154710554" }
      ] 
    })
    assert changeset.valid?
  end
  
  test "check failure when child has start phone outside parent phone range" do
    changeset = PhoneRange.changeset(%PhoneRange{}, %{
      start_phone: "+19154710553", end_phone: "+19154710554",
      childs: [
        %{ start_phone: "+19154710552", end_phone: "+19154710553" },
        %{ start_phone: "+19154710554", end_phone: "+19154710554" }
      ] 
    })
    refute changeset.valid?
    cs_child0 = Enum.at(get_change(changeset, :childs), 0)
    assert List.keymember?(cs_child0.errors, :start_phone, 0) 
  end

  test "check failure when child has start and end phone outside parent phone range" do
    changeset = PhoneRange.changeset(%PhoneRange{}, %{
      start_phone: "+19154710553", end_phone: "+19154710554",
      childs: [
        %{ start_phone: "+19154710553", end_phone: "+19154710553" },
        %{ start_phone: "+19154710551", end_phone: "+19154710555" }
      ] 
    })
    refute changeset.valid?
    cs_child1 = Enum.at(get_change(changeset, :childs), 1)
    assert List.keymember?(cs_child1.errors, :start_phone, 0) 
    assert List.keymember?(cs_child1.errors, :end_phone, 0) 
  end

end
