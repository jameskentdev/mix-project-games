defmodule Games.Wordle do
  @doc """
  The module documentation for Games.Wordle.
  """

  @doc """
  The feedback method which parses two inputs, answer and guess, and determines
  whether any characters in guess match the answer.
  """
  def feedback(answer, guess) do
    split_answer = String.split(answer, "", trim: true)
    split_guess = String.split(guess, "", trim: true)

    {split_answer, split_guess}
    |> find_green()
    |> find_yellow()
    |> find_grey()
    |> elem(1)
  end

  @doc """
    Accepts two lists containing the answer and the guess split into single characters.
    Enum.zip -> sets the nth character of both lists into one tuple
    Enum.map -> pattern match on the tuples, if the characters match return {nil, :green}
    otherwise return it unchanged. This ensures that the character from the answer is erased,
    but the character from the guess is set to :green.
    Enun.unzip -> return the elements back to the original format
  """
  def find_green({answer, guess}) do
    Enum.zip(answer, guess)
    |> Enum.map(fn
      {same, same} -> {nil, :green}
      unchanged -> unchanged
    end)
    |> Enum.unzip()
  end

  @doc """
    For each character, check if another character at another index matches.
  """
  def find_yellow({answer, guess}) do
    # We want to return both {answer, guess} for later use.
    Enum.reduce(guess, {answer, guess}, fn
      # Reduce over guess, so enumerates over each character in guess.
      # Accumelate two lists again, which are our original lists which we modify.
      guess_char, {answer_acc, guess_acc} ->
        # Find indexes of characters that match
        guess_index = Enum.find_index(guess_acc, fn char -> guess_char == char end)
        answer_index = Enum.find_index(answer_acc, fn char -> guess_char == char end)

        # Does this character match anywhere in the answer list? If so, it's a match
        # and replace with {nil, :yellow}.
        if answer_index do
          # Elixir data is immutable, so we need to get the new lists
          # and return them for the next iteration.
          updated_answer_acc = List.replace_at(answer_acc, answer_index, nil)
          updated_guess_acc = List.replace_at(guess_acc, guess_index, :yellow)
          {updated_answer_acc, updated_guess_acc}
        else
          # If no match, then return the lists unmodified
          {answer_acc, guess_acc}
        end
    end)
  end

  def find_grey({answer, guess}) do
    Enum.zip(answer, guess)
    |> Enum.map(fn
      {_, :green} -> {nil, :green}
      {_, :yellow} -> {nil, :yellow}
      _ -> {nil, :grey}
    end)
    |> Enum.unzip()
  end
end
