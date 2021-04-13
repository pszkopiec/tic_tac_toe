$player = "test "
$player1 = " "
$player2 = " "

class Board
  attr_accessor :board
  def initialize 
    @board = Array.new(3){Array.new(3," ")}
  end


  def print_board
    (0..2).each do |row|
      print "      "
      (0..2).each do |col|
        print @board[row][col]
        print " | " unless col == 2
      end
      print "\n"
      print "     -----------\n" unless row == 2
    end
    print "\n"
  end
end

class Game
  def initialize(board) 
    @board = board
  end

  def game_intro
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n Welcome to Tic-Tac-Toe on the Command Line Terminal!\n****~^^~********~^^~*********~^^~*********~^^~********\n\s Here is your board.\n"
  end

  def player_names
    puts "What is your name player 1??"
    $player1 = gets.chomp
    puts "Excellente!\nWhat is your name player 2?"
    $player2 = gets.chomp
    puts "Fantastico! Now, lets have a little coin toss to see who gets to go first. Sound good?(y/n)"
    choice = gets.chomp.upcase
    until choice == "N" || choice == "Y"
      puts "I repeat, you must choose either <y> or <n>!"
      choice = gets.chomp.upcase
    end
      if choice == "N"
        puts "Sorry to see you go so soon Amigo! Ciao! =("
        exit!
      elsif choice == "Y"
        puts "Super sweet! lets do the coin toss\n\n"
      end
  end

  def coin_toss
    puts "Heads or Tails #{$player1}?"
    choice = gets.chomp.downcase
      until choice == "heads" or choice == "tails" do
        puts "Invalid choice amigo. Please type either (heads) or (tails)!"
        choice = gets.chomp.downcase
      end
      puts "\n" * 100
      coin_choices = ["heads","tails"].sample
      puts "The computer chooses: #{coin_choices.upcase}!!\n\n"
      if coin_choices == choice
      puts "#{$player1} goes first!\n"
      elsif coin_choices != choice
      puts "Nice try, but #{$player2} gets to go first!\n"
      end
  end

  def pick_XO
    puts "Would you like to be X's or O's?"
    player = gets.chomp.upcase
      until player == "X" or player == "O" do
        puts "Invalid choice. Please pick either X or O. =)"
        player = gets.chomp.upcase
      end
    $player = player
    puts "Okay, so the first_player will be #{$player}"
  end

  
  def print_board
    @board.print_board
  end

  def place_position(player)
    puts "Where would you like to place your mark? The board positions are numbered #1-9 in consecutive order"
    move = gets.chomp.to_i 
      until move == 1 || move == 2 || move == 3 || move == 4 || move == 5 || move == 6 || move == 7 || move == 8 || move == 9 do
        puts "Invalid Choice, please pick a number #1-9. =)."
        move = gets.chomp.to_i 
      end
    move -= 1
    row = move / 3
    col = move % 3 
      until @board.board[row][col] == " " do
        puts "That sqaure is already occupied! Please pick another!"
        move = gets.chomp.to_i
          until move == 1 || move == 2 || move == 3 || move == 4 || move == 5 || move == 6 || move == 7 || move == 8 || move == 9 do
          puts "Invalid Choice, please pick a number #1-9. =)."
          move = gets.chomp.to_i 
          end
        move -= 1
        row = move / 3
        col = move % 3
      end
      
    @board.board[row][col] = player
    print_board
  end

  def cats_game
    (0..2).each do |row|
      (0..2).each do |cell|
        if @board.board[row][cell] == "X"  || @board.board[row][cell] == "O" 
         next 
        else
          return false
        end
      end
    end
     return true
  end

  def win?
    #checking for columns only.
     (0..2).each do |i|  
       if  @board.board[0][i] == @board.board[1][i] && @board.board[1][i] == @board.board[2][i] && @board.board[0][i] != " " && @board.board[1][i] != " " && @board.board[2][i] != " " && $player == "X"
       return true  
       end
     end
    #check for rows only
     (0..2).each do |i|  
       if  @board.board[i][0] == @board.board[i][1] && @board.board[i][1] == @board.board[i][2] && @board.board[i][0] != " " && @board.board[i][1] != " " && @board.board[i][2] != " " 
         return true
     
       end
     end

    #checking for diagonals
    if @board.board[0][0] == @board.board[1][1] && @board.board[1][1] == @board.board[2][2] && @board.board[0][0] != " " 
      return true
    elsif @board.board[0][2] == @board.board[1][1] && @board.board[1][1] == @board.board[2][0] && @board.board[0][2] != " " 
      return true
    end

  end

  def turn
      if $player == "X"
         $player = "O"
      else
        $player = "X"
      end
  end

  def main_game
     loop do 
      place_position($player)
        if win? == true
         puts "#{$player} wins!"
         exit!
        end
        if cats_game == true
          puts "C A T S GAME!"
          exit!
        end
      turn
      end
  end
end



board = Board.new()
game = Game.new(board)


game.game_intro
board.print_board
game.player_names
game.coin_toss
game.pick_XO
game.main_game
