defmodule Api do
  @callback call(any()) :: {:ok, term} | {:error, term}
end
