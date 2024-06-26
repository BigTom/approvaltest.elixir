defmodule ExApprovalTest do
  use ExUnit.Case
  doctest ExApproval

  test "diffs in one line" do
    diffs =
      Dmp.Diff.main(
        "The quick brown fox jumps over the lazy dog.",
        "The quick brown fox jumps over the lazy dog."
      )

    assert assert ExApproval.same?(diffs)
  end

  test "diffs empty -> written strings" do
    diffs =
      Dmp.Diff.main(
        "",
        "test"
      )

    assert assert not ExApproval.same?(diffs)
  end

  test "diffs empty strings" do
    diffs =
      Dmp.Diff.main(
        "",
        ""
      )

    assert assert ExApproval.same?(diffs)
  end

  test "diffs in one multiline" do
    diffs =
      Dmp.Diff.main(
        """
        The quick brown fox jumps over the lazy dog.
        """,
        """
        The quick brown fox jumps over the lazy dog.
        """
      )

    assert ExApproval.same?(diffs)
  end

  test "diffs in multiline" do
    diffs =
      Dmp.Diff.main(
        """
        the quick brown fox
        jumps over the lazy dog.
        """,
        """
        The quick brown fox
        Jumps over the lazy dog.
        """
      )

    assert not ExApproval.same?(diffs)
  end
end
