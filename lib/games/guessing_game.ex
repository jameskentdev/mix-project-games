defmodule Games.GuessingGame do
  def play(answer \\ nil, attempts \\ 5) do
    answer = answer || Enum.random(1..10)

    guess =
      IO.gets("Guess a number between 1 and 10:\n")
      |> String.trim()
      |> String.to_integer()

    cond do
      answer == guess ->
        IO.puts("You win!")

      attempts == 0 ->
        IO.puts("You lose! The answer was #{answer}")

      guess > answer ->
        IO.puts("Too high!")
        play(answer, attempts - 1)

      guess < answer ->
        IO.puts("Too low!")
        play(answer, attempts - 1)
    end
  end
end
