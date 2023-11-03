require_relative 'words'

class Hangman
  def initialize
    word_data = WordList.words.sample
    @secret_word = word_data[:word]
    @hint = word_data[:hint]
    @lives = 7
    @word_teaser = ""
    @secret_word.size.times do
      @word_teaser += "_ "
    end
  end

  def print_teaser(last_guess = nil)
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser(last_guess)
    new_teaser = @word_teaser.split
    new_teaser.each_with_index do |letter, index|
      if letter == '_' && @secret_word[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    while @lives > 0
      puts "Choisis une lettre"
      guess = gets.chomp

      case guess.downcase
      when "exit"
        puts "Merci d'avoir joué !"
        return
      when "indice"
        puts "Tu réclames l'aide du tout puissant.. Le voici : #{@hint} \n\n"
        print_teaser
      else
        good_guess = @secret_word.include?(guess)
        if good_guess
          puts "Bien joué!"
          print_teaser(guess)
          if @secret_word == @word_teaser.split.join
            puts "Félicitations, tu as gagné !"
            return
          end
        else
          @lives -= 1
          puts "Raté ! Il te reste #{@lives} vies."
          if @lives == 0
            puts "Game over !"
          else
            print_teaser
          end
        end
      end
    end
  end

  def begin
    puts "\n\nBienvenue dans le jeu du pendu...\n\n\n"
    puts "Tapez 'help' pour avoir les commandes du jeu"
    puts "Tapez 'start' pour commencer le jeu"

    command_entered = gets.chomp.downcase
    case command_entered
    when 'start'
      puts "C'est parti !"
      print_teaser
      make_guess
    when 'help'
      puts "Pour quitter le jeu, tapez 'exit'"
      puts "Pour avoir un indice, tapez 'indice'"
      puts "Pour commencer le jeu, tapez 'start'"
      command_entered = gets.chomp.downcase
      case command_entered
      when 'start'
        puts "C'est parti !"
        print_teaser
        make_guess
      when 'exit'
        puts "Merci d'avoir joué !"
      when 'indice'
        puts "Tu réclames l'aide du tout puissant.. Le voici : #{@hint} \n\n"
        print_teaser
        make_guess
    else
      print_teaser
      make_guess
    end
    end
  end
end

game = Hangman.new
game.begin
