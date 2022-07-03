require 'pry'
class TicTacToe
  attr_reader :board

  WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  def initialize
    @board = Array.new(9, ' ')
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(val)
    val.to_i - 1
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(pos)
    @board[pos] != ' '
  end

  def valid_move?(pos)
    (0..8).include?(pos) & !position_taken?(pos)
  end

  def turn_count(player = ' ')
    count = @board.count(player)
    player == ' ' ? 9 - count : count
  end

  def current_player
    turn_count('X') > turn_count('O') ? 'O' : 'X'
  end

  def turn
    # display_board
    puts 'Please enter your next move: '
    loc = input_to_index(gets.chomp)
    valid_move?(loc) ? move(loc, current_player) : turn
    display_board
  end

  def won?
    winner = WIN_COMBINATIONS.map do |combo|
      @board[combo[0]] != ' ' && @board[combo[0]] == @board[combo[1]] && @board[combo[2]] == @board[combo[1]] ? combo : nil
    end
    winner.compact![0]
  end

  def full?
    @board.count(' ') == 0
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    won? ? @board[won?[0]] : nil
  end

  def play
    turn until over?

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end

    # won? ? puts "Congratulations" : puts "Cat's Game!"
  end
end
