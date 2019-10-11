require 'pry'
class TicTacToe
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
    #binding.pry
  end
  
  
  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(board_index, token = "X")
    @board[board_index] = token
  end 
  
  def position_taken?(index_value)
    @board[index_value] == "X" || @board[index_value] == "O"
  end 
  
  def valid_move?(position)
    !position_taken?(position) && position.between?(0, 8)
  end 
  
  def turn
    puts "Please enter a number (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      token = current_player
      move(index, token)
    else
      turn
    end
    display_board
  end
  
  def turn_count
    @board.count{|token| token != " " }
  end 
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end 
  
  def won?
  WIN_COMBINATIONS.detect do |win_combo|
      if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" &&   (@board[win_combo[2]]) == "X"
        return win_combo
      elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
        return win_combo
      end
      false
    end
  end
  
  def full?
    @board.all?{|token| token != " " }
  end
  
  def draw?
    !(won?) && (full?)
  end
  
  def over?
    won? || draw?
  end
  
  def winner
  WIN_COMBINATIONS.detect do |win_combo|
      if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" && (@board[win_combo[2]]) == "X"
        return "X"
      elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
        return "O"
      else
        nil
      end
    end
  end
  
  def winner
    if combo = won?
      @board[combo[0]]
    end
  end
  
  def play
    while over? == false
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
  
end
