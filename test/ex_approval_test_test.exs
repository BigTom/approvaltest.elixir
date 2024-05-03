defmodule ExApprovalTestTest do
  use ExUnit.Case
  doctest ExApprovalTest

  test "diffs in one line" do
    diffs =
      Dmp.Diff.main(
        "The quick brown fox jumps over the lazy dog.",
        "The quick brown fox jumps over the lazy dog."
      )

    assert assert ExApprovalTest.same?(diffs)
  end

  test "diffs empty -> written strings" do
    diffs =
      Dmp.Diff.main(
        "",
        "test"
      )

    assert assert not ExApprovalTest.same?(diffs)
  end

  test "diffs empty strings" do
    diffs =
      Dmp.Diff.main(
        "",
        ""
      )

    assert assert ExApprovalTest.same?(diffs)
  end

  test "diffs in one multiline" do
    diffs = Dmp.Diff.main(
    """
    The quick brown fox jumps over the lazy dog.
    """,
    """
    The quick brown fox jumps over the lazy dog.
    """)
    assert ExApprovalTest.same?(diffs)
  end

  test "diffs in multiline" do
    diffs = Dmp.Diff.main(
    """
    the quick brown fox
    jumps over the lazy dog.
    """,
    """
    The quick brown fox
    Jumps over the lazy dog.
    """)
    assert not ExApprovalTest.same?(diffs)
  end
end
