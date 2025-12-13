defmodule Day9Test do
  use ExUnit.Case

  @input """
  addx 15
  addx -11
  addx 6
  addx -3
  addx 5
  addx -1
  addx -8
  addx 13
  addx 4
  noop
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx 5
  addx -1
  addx -35
  addx 1
  addx 24
  addx -19
  addx 1
  addx 16
  addx -11
  noop
  noop
  addx 21
  addx -15
  noop
  noop
  addx -3
  addx 9
  addx 1
  addx -3
  addx 8
  addx 1
  addx 5
  noop
  noop
  noop
  noop
  noop
  addx -36
  noop
  addx 1
  addx 7
  noop
  noop
  noop
  addx 2
  addx 6
  noop
  noop
  noop
  noop
  noop
  addx 1
  noop
  noop
  addx 7
  addx 1
  noop
  addx -13
  addx 13
  addx 7
  noop
  addx 1
  addx -33
  noop
  noop
  noop
  addx 2
  noop
  noop
  noop
  addx 8
  noop
  addx -1
  addx 2
  addx 1
  noop
  addx 17
  addx -9
  addx 1
  addx 1
  addx -3
  addx 11
  noop
  noop
  addx 1
  noop
  addx 1
  noop
  noop
  addx -13
  addx -19
  addx 1
  addx 3
  addx 26
  addx -30
  addx 12
  addx -1
  addx 3
  addx 1
  noop
  noop
  noop
  addx -9
  addx 18
  addx 1
  addx 2
  noop
  noop
  addx 9
  noop
  noop
  noop
  addx -1
  addx 2
  addx -37
  addx 1
  addx 3
  noop
  addx 15
  addx -21
  addx 22
  addx -6
  addx 1
  noop
  addx 2
  addx 1
  noop
  addx -10
  noop
  noop
  addx 20
  addx 1
  addx 2
  addx 2
  addx -6
  addx -11
  noop
  noop
  noop
  """

  @output """
  ##..##..##..##..##..##..##..##..##..##..
  ###...###...###...###...###...###...###.
  ####....####....####....####....####....
  #####.....#####.....#####.....#####.....
  ######......######......######......####
  #######.......#######.......#######.....\
  """

  test "parsing" do
    data = Day10.parse(@input)
    assert length(data) == 146
    assert Enum.at(data, 0) == {:addx, 15}
  end

  describe "running" do
    test "a partial program" do
      data = Day10.parse(@input)
      assert {4, 5, [{2, 16}, {4, 5}]} = Day10.run(data, 4)
    end

    test "a full program" do
      data = Day10.parse(@input)
      assert {240, 17, _} = Day10.run(data)
    end
  end

  test "register probing" do
    data = Day10.parse(@input)
    {_, _, history} = Day10.run(data)

    assert Day10.register_during(1, history) == 1
    assert Day10.register_during(20, history) == 21
    assert Day10.register_during(60, history) == 19
    assert Day10.register_during(100, history) == 18
    assert Day10.register_during(140, history) == 21
    assert Day10.register_during(180, history) == 16
    assert Day10.register_during(220, history) == 18
  end

  describe "signal strength" do
    test "at cycle" do
      data = Day10.parse(@input)
      {_, _, history} = Day10.run(data)

      assert Day10.signal_strength(20, history) == 420
      assert Day10.signal_strength(60, history) == 1140
      assert Day10.signal_strength(100, history) == 1800
      assert Day10.signal_strength(140, history) == 2940
      assert Day10.signal_strength(180, history) == 2880
      assert Day10.signal_strength(220, history) == 3960
    end

    test "of program" do
      data = Day10.parse(@input)
      assert Day10.signal_strength(data) == 13140
    end
  end

  describe "drawing" do
    test "during a single cycle" do
      assert Day10.draw(0, 2) == "."
      assert Day10.draw(1, 2) == "#"
      assert Day10.draw(2, 2) == "#"
      assert Day10.draw(3, 2) == "#"
      assert Day10.draw(4, 2) == "."
    end

    test "for an entire program" do
      data = Day10.parse(@input)
      screen = Day10.draw(data)
      assert screen == @output
    end
  end

  test "part 1" do
    assert Day10.part1() == 14920
  end

  test "part 2" do
    IO.puts Day10.part2() == """
    ###..#..#..##...##...##..###..#..#.####.
    #..#.#..#.#..#.#..#.#..#.#..#.#..#....#.
    ###..#..#.#....#..#.#....###..#..#...#..
    #..#.#..#.#....####.#....#..#.#..#..#...
    #..#.#..#.#..#.#..#.#..#.#..#.#..#.#....
    ###...##...##..#..#..##..###...##..####.\
    """
  end
end
