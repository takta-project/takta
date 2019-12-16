defmodule Takta.CollectionsTest do
  use Takta.{DataCase, Query}
  alias Takta.{
    Accounts,
    Collections
  }

  describe "collections 🗃 ::" do
    test "find all works as expected" do
      assert Collections.all() |> length() > 0
    end

    test "find_by_id works as expected" do
      one = Collections.all() |> List.first()
      assert Collections.find_by_id(one.id)
    end

    test "find_by_id returns nil if collection not found" do
      refute Collections.find_by_id(UUID.uuid4())
    end

    test "can create new collection" do
      user = Accounts.all() |> List.first()

      {:ok, collection} = Collections.create(%{
        name: "test-collection",
        owner_id: user.id
      })

      assert Collections.find_by_id(collection.id)
    end

    test "can not create new collection if input is not valid" do
      {:error, changeset} = Collections.create(%{
        name: "test-name"
      })

      assert changeset.errors == [
        owner_id: {"can't be blank", [validation: :required]}
      ]
    end

    test "can update collection if input is valid" do
      collection = Collections.all() |> List.first()
      {:ok, updated} = Collections.update(collection, %{name: "Rocket man"})
      assert updated.name == "Rocket man"
    end

    test "can not update collection if input is not valid" do
      comment = Collections.all() |> List.first()
      assert {:error, changeset} = Collections.update(comment, %{owner_id: nil})
      assert changeset.errors == [
        owner_id: {"can't be blank", [validation: :required]}
      ]
    end

    test "can delete collection" do
      collection = Collections.all() |> List.first()
      {:ok, deleted} = Collections.delete(collection.id)
      assert deleted.id == collection.id
    end

    test "can not delete collection if it does not exist" do
      assert {:error, :not_found} = Collections.delete(UUID.uuid4())
    end
  end
end