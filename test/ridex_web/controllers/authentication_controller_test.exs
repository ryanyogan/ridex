defmodule RidexWeb.AuthenticationControllerTest do
  use RidexWeb.ConnCase

  describe "POST /api/authenticate" do
    test "returns OK with a valid JWT token", %{conn: conn} do
      body =
        conn
        |> post("/api/authenticate", %{
          "phone" => "+15555555555",
          "type" => "rider"
        })
        |> json_response(200)

      %{
        "id" => user_id,
        "token" => token,
        "type" => "rider"
      } = body

      assert {:ok, _} = Ridex.Guardian.decode_and_verify(token, %{"sub" => user_id})
    end

    test "creates a new user if not present", %{conn: conn} do
      body =
        conn
        |> post("/api/authenticate", %{
          "phone" => "+15555555555",
          "type" => "rider"
        })
        |> json_response(200)

      %{"id" => user_id} = body

      assert [%{id: new_user_id}] = Ridex.User |> Ridex.Repo.all()
      assert new_user_id == user_id
    end

    test "returns 400 with an incorrect user type", %{conn: conn} do
      conn
      |> post("/api/authenticate", %{
        "phone" => "+15555555555",
        "type" => "wrong_type"
      })
      |> json_response(400)
    end
  end
end
