def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  integer = input.to_i
  position = integer - 1
  return position
end

def move(board, position, char)
  board[position] = char
end

def valid_move?(board, index)
  if !position_taken?(board, index) && 0 <= index && 8 >= index
    return true
  end
end
# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    return true
  elsif board[index] == " " || board[index] == "" || board[index] == "nil"
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) == true
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |char|
    if char == "X" || char == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 1
    return "O"
  elsif turns % 2 == 0
    return "X"
  end
end

WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def won?(board)
  state = 0
  WIN_COMBINATIONS.each do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X" || board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      state = 1
      return combination
    end
  end
  if state == 0
    return false
  end
end

def full?(board)
  filled = 0
  board.each do |position|
    if position == "X" || position == "O"
      filled += 1
    end
  end
  if filled == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  elsif won?(board)
    return false
  end
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    WIN_COMBINATIONS.each do |combination|
      if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
        return "X"
      elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
        return "O"
      end
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
