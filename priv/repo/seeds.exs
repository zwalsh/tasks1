# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasks.Repo.insert!(%Tasks.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# taken from Nat Tuck's users impl: https://khoury.neu.edu/~ntuck/courses/2019/01/cs4550/notes/11-add-users/notes.html
alias Tasks.Repo
alias Tasks.Users.User

hash = Argon2.hash_pwd_salt("pass")

alice = %User{email: "alice@example.com", password_hash: hash}
Repo.insert!(alice)
Repo.insert!(%User{email: "bob@example.com", password_hash: hash})
