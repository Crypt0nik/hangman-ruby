 class Hangman
   def initialize
     @word = words.sample
     @lives = 7
     @word_teaser = ""

     @word.first.size.times do
      @word_teaser += "_ "
    end
   end

    def words
      [
        ["maison", "Ce qui te sert de toit"],
      ]
    end

    def print_teaser last_guess = nil
      update_teaser(last_guess) unless last_guess.nil?
      puts @word_teaser
    end

    def update_teaser last_guess
      new_teaser = @word_teaser.split
      new_teaser.each_with_index do |letter, index|
        if letter == '_' && @word.first[index] == last_guess
          new_teaser[index] = last_guess
        end
      end

      @word_teaser = new_teaser.join(' ')
    end

    def make_guess
      if @lives > 0
        puts "Choisis une lettre"
        guess = gets.chomp

        good_guess = @word.first.include? guess

        if guess == "exit"
          puts "Merci d'avoir joué !"
        elsif good_guess
          puts "Bien joué !"

          print_teaser guess

          if @word.first == @word_teaser.split.join
            puts "Félicitations, tu as gagné !"
          else
          make_guess
          end
        else
          @lives -= 1
          puts "Raté ! Tu as #{ @lives } vies restantes"
          make_guess
        end

      else @lives <= 0
        puts "Game over !"
      end
    end

    def begin
      puts "Bienvenue dans le jeu du pendu... Ton mot a #{ @word.first.size } lettres !"
      puts "Pour quitter le jeu, tape 'exit'"
      print_teaser

      puts "Indice : #{ @word.last }"

      make_guess
    end

 end

game = Hangman.new
game.begin
