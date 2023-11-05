require_relative 'words'

RESET = "\e[0m"
RED = "\e[91m"

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
      puts "\n\n\n\n"
      puts "Choisis une #{RED}lettre#{RESET}"
      guess = gets.chomp

      case guess.downcase
      when "exit"
        puts"\033[H\033[2J \n\n\n\n"
        puts "#{RED}Merci#{RESET} d'avoir joué ! \n\n\n"
        return
      when "indice"
        puts"\033[H\033[2J \n\n\n\n"
        puts "Tu réclames l'aide du tout #{RED}puissant#{RESET}.. Le voici : #{@hint} \n\n\n"
        print_teaser
      else
        good_guess = @secret_word.include?(guess)
        if good_guess
          puts "\033[H\033[2J \n\n\n\n"
          puts "#{RED}Bien#{RESET} Joué! \n\n\n"
          print_teaser(guess)
          if @secret_word == @word_teaser.split.join
            puts"\033[H\033[2J \n\n\n\n"
            puts "Félicitations, tu as gagné !\n"
            puts "Le mot était #{@secret_word}\n\n\n\n"
            return
          end
        else
          @lives -= 1
          puts "\033[H\033[2J \n\n\n\n"
          puts "#{RED}Raté#{RESET} ! Il te reste #{RED}#{@lives}#{RESET} vies. \n\n\n"
          if @lives == 0
            puts "Game #{RED}Over#{RESET} !\n\n\n\n"
          else
            print_teaser
          end
        end
      end
    end
  end

  def begin
    puts "\033[H\033[2J"+ RED
    puts "\n\n\n    ─────────────────────────────" +RESET
    puts "  Bienvenue dans le jeu du pendu..." + RED
    puts "    ─────────────────────────────\n\n\n"
    puts RESET
    puts "Tapez #{RED}help#{RESET} pour avoir les commandes du jeu"
    puts ""
    puts "Tapez #{RED}start#{RESET} pour commencer le jeu\n\n\n"

    command_entered = gets.chomp.downcase
    case command_entered
    when 'start'
      puts "\033[H\033[2J\n\n\n\n"
      puts "C'est parti !\n\n\n"
      print_teaser
      make_guess
    when 'help'
      puts "\033[H\033[2J\n\n\n\n"
      puts "Pour quitter le jeu, tapez #{RED}Exit#{RESET}\n\n"
      puts "Pour avoir un indice, tapez #{RED}Indice#{RESET}\n\n"
      puts "Pour commencer le jeu, tapez #{RED}Start#{RESET}\n\n"
      command_entered = gets.chomp.downcase
      case command_entered
      when 'start'
        puts"\033[H\033[2J\n\n\n\n"
        puts "C'est parti !\n\n\n"
        print_teaser
        make_guess
      when 'exit'
        puts"\033[H\033[2J\n\n\n\n"
        puts "Merci d'avoir joué !\n\n\n\n"
      when 'indice'
        puts"\033[H\033[2J\n\n\n\n"
        puts "Tu réclames l'aide du tout #{RED}puissant#{RESET}.. Le voici : #{@hint} \n\n\n"
        print_teaser
        make_guess
    else
      puts"\033[H\033[2J\n\n\n\n"
      puts "#{RED}Commande Inconnue#{RESET}, veuillez recommencer\n\n\n\n"
      command_entered = gets.chomp.downcase
    end
    end
  end
end

game = Hangman.new
game.begin
