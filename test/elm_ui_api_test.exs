defmodule ElmUITest do
  use ExUnit.Case
  use Maru.Test, for: ElmUI.API
  doctest ElmUI.API

  test "/" do
  	a = %Plug.Conn{} = conn(:get, "/") |> make_response
  	assert Poison.decode!(a.resp_body)["error"] == "Not found!"
  end
end
