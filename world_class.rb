class World
# require_relative 'voter_module.rb'
# include MainMenu
attr_reader :republicans, :democrats

  def initialize(politicians_list_test)
    @voters_list = []
    @politicians_list = politicians_list_test
    @votes_list = []
    @republicans = []
    @democrats = []
  end

  def simulation
    categorize_politicians
    # puts "The republicans are:"
    #   @republicans.each{|i| puts i[0]}
    # puts "\nThe democrats are:"
    #   @democrats.each{|i| puts i[0]}
  end

private
#this is meant to separate the list of all politicians to a list of democrats and a list of republicans
  def categorize_politicians
    @politicians_list.each do |politician|
      if politician[1] == "democrat"
        @democrats << politician
      elsif politician[1] == "republican"
        @republicans << politician
      else
        raise "Second item in politicians list array is formatted incorrectly: #{p politician[1]}"
      end
    end
  end
end


def test_simulation
  pol = [["jimmy", "democrat"], ["Red", "republican"], ["Glenn", "republican"], ["Megan", "democrat"]]
  # pol2 = [{"Jimmy LAST" => "Democrat"}, {"Red First" => "Republican"}]
  world_sim = World.new(pol)
  world_sim.simulation
  p world_sim.republicans == [["Red", "republican"], ["Glenn", "republican"]]
  p world_sim.democrats == [["jimmy", "democrat"], ["Megan", "democrat"]]
end

test_simulation
