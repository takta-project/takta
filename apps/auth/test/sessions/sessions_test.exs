defmodule Auth.SessionsTest do
  @invalid_token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

  use Auth.DataCase
  use Auth.Query
  alias Auth.Sessions

  describe "sessions 🍪 ::" do
    test "find all works as expected" do
      assert Sessions.all() |> length() > 0
    end

    test "find by user id works as expected" do
      assert {:ok, session} = Sessions.create(UUID.uuid4())
      assert (%Sessions.Session{} = _session) = Sessions.find_by_user_id(session.user_id)
    end

    test "find by user id returns nil if not found" do
      assert Sessions.find_by_user_id(UUID.uuid4()) == nil
    end

    test "can create session works as expected" do
      assert {:ok, token} = Sessions.create(UUID.uuid4())
    end

    test "can create session fails if no input given" do
      assert {:error, _changeset} = Sessions.create(nil)
    end

    test "is_valid? token works as expected" do
      {:ok, token} = Sessions.create(UUID.uuid4())
      assert Sessions.is_valid?(token.token)
    end

    test "is_valid? session works as expected if token is invalid or malformed" do
      refute Sessions.is_valid?(@invalid_token)
    end
  end
end