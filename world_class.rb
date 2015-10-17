class World
# require_relative 'voter_module.rb'
# include MainMenu

  def initialize(politicians_list_test)
    @voters_list = []
    @politicians_list = [politicians_list_test]
    @votes_list = []
    @republicans = []
    @democrats = []
  end

  def simulation
  end


#private
#this is meant to separate the list of all politicians to a list of democrats and a list of republicans
  def categorize_politicians
    @politicians_list.each do |politician|
      if politician[1] == "democrat"
        @democrats << politician
        # p @democrats
      elsif politician[1] == "republican"
        @republicans << politician
      # else
      #   raise "Second item in politicians list array is formatted incorrectly: #{p politician[1]}"
      end
    end
  end
end



pol = [["jimmy", "democrat"], ["Red", "republican"]]
pol2 = [{"Jimmy LAST" => "Democrat"}, {"Red First" => "Republican"}]

world = World.new(pol)
world.categorize_politicians
