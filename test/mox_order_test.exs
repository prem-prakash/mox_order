defmodule MoxOrderTest do
  use ExUnit.Case

  import Mox
  setup :verify_on_exit!
  setup :set_mox_global

  def mock_api(map) do
    expect(ApiMock, :call, 1, fn ^map ->
      :ok
    end)
  end

  setup do
    maps = [
      %{a: 1},
      %{a: 2},
      %{a: 3},
      %{a: 4},
    ]
    %{maps: maps}
  end

  test "same order OK", %{maps: maps} do
    Enum.each(maps, & mock_api(&1))

    assert [:ok, :ok, :ok, :ok] == MoxOrder.perform(maps)
  end

  test "different order breaks", %{maps: maps} do
    Enum.each(maps, & mock_api(&1))

    assert [:ok, :ok, :ok, :ok] == MoxOrder.perform(Enum.reverse(maps))
  end
end
