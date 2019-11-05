defmodule Takta.Fixtures do
  use Takta.Query
  alias Takta.{
    Accounts,
    Annotations,
    Comments,
    Invites,
    Members,
    Whiteboards
  }

  def run do
    {:ok, user1} = Accounts.create(%{
      email: "su@example.com",
      full_name: "Sudo name",
      password: "12345678",
      is_active: true,
      is_admin: true
    })

    {:ok, admin} = Accounts.create(%{
      email: "admin@example.com",
      full_name: "Admin name",
      password: "12345678",
      is_active: true,
      is_admin: true
    })

    {:ok, consultant} = Accounts.create(%{
      email: "consultant1@example.com",
      full_name: "Con1 name",
      password: "12345678",
      is_active: true,
      is_admin: false
    })

    Accounts.create(%{
      email: "consultant2@example.com",
      full_name: "Con2 name",
      password: "12345678",
      is_active: true,
      is_admin: false
    })

    {:ok, wb1} = Whiteboards.create(%{
      name: "xyz",
      path: "my/path.png",
      owner_id: user1.id
    })

    {:ok, wb2} = Whiteboards.create(%{
      name: "xyz",
      path: "my/path.png",
      owner_id: user1.id
    })

    {:ok, comment1} = Comments.create(%{
      content: "Comment 1",
      author_id: user1.id,
      whiteboard_id: wb1.id
    })

    {:ok, comment2} = Comments.create(%{
      content: "Comment 2",
      author_id: user1.id,
      whiteboard_id: wb1.id
    })

    Comments.create(%{
      content: "Comment 3",
      author_id: user1.id,
      whiteboard_id: wb1.id
    })

    Comments.create(%{
      content: "Comment 4",
      author_id: user1.id,
      whiteboard_id: wb1.id
    })

    Annotations.create(%{
      coords: %{
        x: 1,
        y: 1
      },
      comment_id: comment1.id,
      whiteboard_id: wb1.id
    })

    Annotations.create(%{
      coords: %{
        x: 8,
        y: 8
      },
      comment_id: comment2.id,
      whiteboard_id: wb1.id
    })

    Invites.create(%{
      used: false,
      code: "my-shiny-invite",
      created_by_id: user1.id,
      whiteboard_id: wb1.id
    })

    Invites.create(%{
      used: false,
      code: "my-1m-bucks-invite",
      created_by_id: user1.id,
      whiteboard_id: wb1.id
    })

    Invites.create(%{
      used: false,
      code: "my-1b-bucks-invite",
      used_by_id: consultant.id,
      created_by_id: user1.id,
      whiteboard_id: wb1.id
    })

    Members.create(%{
      member_id: user1.id,
      whiteboard_id: wb1.id
    })

    Members.create(%{
      member_id: consultant.id,
      whiteboard_id: wb2.id
    })

    Members.create(%{
      member_id: admin.id,
      whiteboard_id: wb2.id
    })
  end
end
