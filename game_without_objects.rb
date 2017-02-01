choices = {r: "rock", s: "scissors", p: "paper"}
player_score = 0
computer_score = 0

while player_score < 2 && computer_score < 2

  player_choice = nil
  puts "Player Score: #{player_score}, Computer Score: #{computer_score}"

  while !choices.keys.include?(player_choice)
    puts "That is not a valid choice." if !player_choice.nil?
    print "Choose rock (r), paper (p), or scissors (s): "
    player_choice = gets.chomp.to_sym
  end

  puts "Player chose #{choices[player_choice]}."
  computer_choice = choices.keys.sample
  puts "Computer chose #{choices[computer_choice]}."

  if player_choice == computer_choice
    puts "It's a tie! |-o-|"
    puts "Choose again."
  elsif choices.keys.index(player_choice) > choices.keys.index(computer_choice) || (player_choice == :r && computer_choice == :p)
    puts "#{choices[computer_choice].capitalize} beats #{choices[player_choice]}.  Computer wins the round."
    computer_score += 1
  else
    puts "#{choices[player_choice].capitalize} beats #{choices[computer_choice]}.  Player wins the round."
    player_score += 1
  end

end

if player_score == 2
  puts "Player wins!"
else
  puts "Computer wins!"
end
