defmodule ExApproval do
  @spec gen_test_data_set(keyword(), fun()) :: list()
  @doc """
  Helper functions to implement approval testing
  """

  def gen_test_data_set(parameters, input_constructor) do
    parameters
    |> Enum.map(fn {id, lst} -> Enum.map(lst, fn el -> {id, el} end) end)
    |> permutations()
    |> Enum.map(&input_constructor.(&1))
  end

  @spec permutations(list(list())) :: map()
  def permutations([]), do: %{}
  def permutations([hd]), do: Enum.map(hd, &Enum.into([&1], %{}))

  def permutations([hd | tail]) do
    for {k, v} <- hd,
        submap <-
          Enum.map(
            permutations(tail),
            fn submap -> Map.put(submap, k, v) end
          ) do
      submap
    end
  end

  def same?([]), do: true

  def same?(diffs) do
    keys = Keyword.keys(diffs)

    length(keys) == 1 && List.first(keys) == :equal
  end
end
