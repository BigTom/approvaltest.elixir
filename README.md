# Approval Testing Framework for Elixir
[![.github/workflows/test.yml](../../actions/workflows/test.yml/badge.svg)](../../actions/workflows/test.yml)


## Status
Work in progress  

Currently the code consists of a couple of helper functions you can use to run an approval test inside a unit test.  It has no line by line comparitor yet.  I am simply using a diff plugin.

A test looks something like teh one below.

1. The input builder is a hook function that assembles the parameters to call the SUT (System Under Test) with.
1. The test data is a Keyword that holds the various values that exercise the corner cases.
1. `ExApproval.gen_test_data_set(test_data_set, input_builder)` creates a list of parameter sets that contains all the permutations of the test data. 
1. All the file writing and comparing files is still in the test.


```elixir
test "Approval test" do
    input_builder = fn %{name: name, sell_in: sell_in, quality: quality} ->
      %Item{name: name, sell_in: sell_in, quality: quality}
    end

    test_data =
      [
        name: [
          "Others",
          "Aged Brie",
          "Backstage passes to a TAFKAL80ETC concert",
          "Sulfuras, Hand of Ragnaros"
        ],
        sell_in: [-1, 0, 1, 10, 50],
        quality: [0, 1, 49, 50]
      ]
      |> ExApproval.gen_test_data_set(input_builder)

    candidate_items =
      GildedRose.update_quality(test_data)
      |> inspect(pretty: true, infinity: true)

    File.write!("test/candidate.txt", candidate_items)

    approved_items = File.read!("test/approved.txt")
    assert(approved_items == candidate_items)
  end
end

```