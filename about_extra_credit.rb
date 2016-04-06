# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

class DiceSet
  attr_reader :values
  def roll i
    @values = []
    randNum = Random.new
    while (i > 0) do
      @values << randNum.rand(5) + 1
      i -= 1
    end
    @values
  end
end

class Player
	attr_accessor :pointNum, :values

	def initialize
		@pointNum = 0
		@values = []
	end
end

class Game
	attr_accessor :numWinPoint
	attr_reader :scoreHash

	def initialize
		initialize_variables
		begin			
			puts
			puts 'Press q for quit'
			puts "1. Set num of points for win (now: '#{@numWinPoint}')."
			puts '2. Get score list.'
			puts '3. Start playing'
			choice = gets.chomp
			case choice
			when '1'  
				set_num_win_point 
			when '2' 
				show_score_list
			when '3'
				play
			when 'q'
				puts 'Goodbye'
			else puts 'Invalid value'
			end
		end until choice == 'q'
	end

	def initialize_variables
		@numWinPoint = 3000
		@scoreHash = {one: 100, five: 50, ones: 1000}
		i = 2
		[:twos, :threes, :fours, :fives, :sixes].each do |key|
			@scoreHash[key] = i*100
			i += 1
		end
	end

	def set_num_win_point
		print 'Input num of points for win: '
		num = gets.chomp
		@numWinPoint = num
	end

	def show_score_list
		@scoreHash.each { |key, value| puts (key == :one || key == :five) ? "#{key} is #{value}" : "three #{key} is #{value}"}
	end

	def play
		@player = Player.new
		dice = DiceSet.new
		begin 
			puts "Sum of points: #{@player.pointNum}"
			puts 'The valuse of the dice:'
			@player.values = [] if @player.values.size == 5
			@values = dice.roll 5 - @player.values.size
			puts @values
			addedPoints = add_points 
			puts 'Fixed values:'
			puts @player.values
			@player.pointNum += addedPoints
			if @player.pointNum >= @numWinPoint
				puts 'You win! (**,)'
				break
			end
			puts "addedPoints: #{addedPoints}"
			if addedPoints > 0
				puts 'Continue?(y/n): '
				choice = gets.chomp
				break unless choice == 'y' || choice == '+'
			else
				puts 'Game over'
			end
		end while addedPoints > 0
	end

	def add_points 
		addedPoints = 0		
		numCount = add_values_and_get_count_1_5 1
		addedPoints += get_points(1, numCount, 1000, 100)			
		numCount = add_values_and_get_count_1_5 5
		addedPoints += get_points(5, numCount, 500, 50)
		[2,3,4,6].each do |el| 
			numCount = add_values_and_get_count el
			addedPoints += get_points(el, numCount, el*100)
		end
		addedPoints
	end

	def add_values_and_get_count_1_5 num
		numCount = @values.count num
		numCount.times { @player.values.push num}
		numCount
	end

	def add_values_and_get_count num
		numCount = @values.count num
		3.times { @player.values.push num} if numCount >= 3
		numCount
	end

	def get_points(num, numCount, three, one = 0)
		numCount = numCount < 3 ? one * numCount : three + one * (numCount - 3)		
		numCount
	end

end

Game.new