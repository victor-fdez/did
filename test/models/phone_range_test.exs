defmodule Did.PhoneRangeTest do
  use Did.ModelCase
  import Did.ModelCase.Macros

  #alias Did.PhoneRange

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

end
