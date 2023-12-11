defmodule Games.RockPaperScissors do
  @moduledoc """
  The module documentation for Games.RockPaperScissors.
  """

  @doc """
  The play method which starts the RockPaperScissors game.
  """
  def play() do
    ai = Enum.random([:rock, :paper, :scissors])

    guess =
      IO.gets("Choose rock, paper, or scissors: ")
      |> String.trim()
      |> case do
        "rock" -> :rock
        "paper" -> :paper
        "scissors" -> :scissors
      end

    cond do
      ai == guess -> "It's a tie!"
      beats?(guess, ai) -> "You win!"
      beats?(ai, guess) -> "You lose!"
    end
  end

  defp beats?(player1, player2) do
    {player1, player2} in [{:rock, :scissors}, {:paper, :rock}, {:scissors, :paper}]
  end
end
