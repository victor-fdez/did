# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Did.Repo.insert!(%Did.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Did.PhoneRange
alias Did.Repo

phone1 = Repo.insert! %PhoneRange{ start_phone: "+1 915 471 0552", end_phone: "+1 915 471 0553" }
phone2 = Repo.insert! %PhoneRange{ start_phone: "+1 915 471 0552", end_phone: "+1 915 471 0552", parent: phone1 }

