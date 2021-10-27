defmodule MoxOrder do
  @moduledoc """
  Documentation for `MoxOrder`.
  """

  def perform(maps) do
    maps
    |> Enum.map(fn map ->
      Task.async(fn ->
        ApiMock.call(map)
      end)
    end)
    |> Enum.map(&Task.await/1)
  end
end
