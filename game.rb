require 'pry'
class Round
  CHOICES = {"r": "rock", "s": "scissors", "p": "paper"}
  def initialize(player_name, computer_name, player_choice, computer_choice)
    @player_name = player_name
    @computer_name = computer_name
    @player_choice = player_choice
    @computer_choice = computer_choice
  end
  def determine_winner
    if @player_choice == @computer_choice
      "It's a tie! |-o-|"
    elsif next_choice(@player_choice) == @computer_choice
      @player_name
    else
      @computer_name
    end
  end
  def next_choice(choice)
    if CHOICES.keys.index(choice) < (CHOICES.length - 1)
     CHOICES.keys[CHOICES.keys.index(choice) + 1]
   else
     CHOICES.keys[0]
   end
  end
end

class Player
  attr_reader :name
  attr_accessor :score
  def initialize(name = "Player")
    @name = name
    @score = 0
  end
end

class Game
  def initialize
    @computer = Player.new("Computer")
    @player_choice = nil
  end
  def play
    print "Hello!  Please enter your name: "
    @player = Player.new(gets.chomp.capitalize)
    while no_winner
      puts formatted_score
      @computer_choice = Round::CHOICES.keys.sample
      get_player_input
      puts announce_choices
      round = Round.new(@player.name, @computer.name, @player_choice, @computer_choice)
      @winner = round.determine_winner
      puts announce_winner
    end
    puts "#{@winner} wins the game!"
  end
  def announce_winner
    @winner == "It's a tie! |-o-|" ? @winner : update_score
  end
  def announce_choices
    "#{@player.name} chose #{Round::CHOICES[@player_choice]}.\n#{@computer.name} chose #{Round::CHOICES[@computer_choice]}."
  end
  def formatted_score
    "#{@player.name}'s Score: #{@player.score}, #{@computer.name}'s Score: #{@computer.score}"
  end
  def get_player_input
    @player_choice = nil
    while !Round::CHOICES.keys.include?(@player_choice)
      (puts "Invalid input.") if @player_choice != nil
      print "Choose rock (r), paper (p), or scissors (s): "
      @player_choice = gets.chomp.downcase.to_sym
    end
  end
  def update_score
    if @winner == "#{@player.name}"
      @player.score += 1
      "#{Round::CHOICES[@player_choice].capitalize} beats #{Round::CHOICES[@computer_choice]}! #{@winner} wins the round."
    else
      @computer.score += 1
      "#{Round::CHOICES[@computer_choice].capitalize} beats #{Round::CHOICES[@player_choice]}! #{@winner} wins the round."
    end
  end
  def no_winner
    @player.score < 2 && @computer.score < 2
  end
end

game = Game.new
game.play
