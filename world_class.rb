class World
# require_relative 'voter_module.rb'
# include MainMenu
  attr_reader :republicans_on_ballot, :democrats_on_ballot, :tea_party_members, :conservatives, :neutrals, :liberals, :socialists, :overall_winner, :votes, :VOTER_ASSOCIATIONS

  def initialize(politician_list, voter_list)
    #People type aggregate
    @voter_list = voter_list
    @politician_list = politician_list

    #candidates by category
    @republicans_on_ballot = []
    @democrats_on_ballot = []

    #affiliation membership
    @tea_party_members = []
    @conservatives = []
    @neutrals = []
    @liberals = []
    @socialists = []

    #winners
    @republican_winner = []
    @democratic_winner = []
    @overall_winner = []

    #all votes
    @votes = []

    #probabilities and relationships
    @TEA_PARTY_PROBABLITY = {republican: 90, democrat: 10}
    @CONSERVATIVE_PROBABLITY = {republican: 75, democrat: 25}
    @NEUTRAL_PROBABLITY = {republican: 50, democrat: 50}
    @LIBERAL_PROBABLITY = {republican: 25, democrat: 75}
    @SOCIALIST_PROBABLITY = {republican: 10, democrat: 90}
    @VOTER_ASSOCIATIONS = [{party: @tea_party_members, prob: @TEA_PARTY_PROBABLITY},
                          {party: @conservatives, prob: @CONSERVATIVE_PROBABLITY},
                          {party: @neutrals, prob: @NEUTRAL_PROBABLITY},
                          {party: @liberals, prob: @LIBERAL_PROBABLITY},
                          {party: @socialists, prob: @SOCIALIST_PROBABLITY}]

  end

  def simulation
    categorize_politicians
    categorize_voters
    @republican_winner = @republicans_on_ballot.sample
    @democratic_winner = @democrats_on_ballot.sample
    @VOTER_ASSOCIATIONS.each do |association|
      association[:party].length.times {cast_vote(association[:prob])}
    end
    if @votes.count(1) > @votes.size/2
      @overall_winner << @republican_winner
    elsif @votes.count(1) == @votes.size/2
      puts "There was a draw! RECOUNT AND MAKE HISTORY!"
      simulation
    else
      @overall_winner << @democratic_winner
    end
  end

private
  def categorize_politicians
    @politician_list.each do |politician|
      if politician[:party] == "democrat"
        @democrats_on_ballot << politician
      elsif politician[:party] == "republican"
        @republicans_on_ballot << politician
      end
    end
  end

  def categorize_voters
    @voter_list.each do |voter|
      case voter[:affiliation]
      when "tea party"
        @tea_party_members << voter
      when "conservative"
        @conservatives << voter
      when "neutral"
        @neutrals << voter
      when "liberal"
        @liberals << voter
      when "socialist"
        @socialists << voter
      end
    end
  end

  def cast_vote(prob_type)
    reps = Array.new(prob_type[:republican],1)
    deps = Array.new(prob_type[:democrat],0)
    all = (reps << deps).flatten!
    vote = all.sample
     if vote == 1
       @votes << 1
     else
       @votes << 0
     end
  end
end

# def choose_weighted(weighted)
#   sum = weighted.inject(0) do |sum, item_and_weight|
#     sum += item_and_weight[1]
#   end
#   target = rand(sum)
#   weighted.each do |item, weight|
#     return item if target <= weight
#     target -= weight
#   end
# end
# 10.times{puts choose_weighted(@TEA_PARTY_PROBABLITY)}


def test_simulation
  all_politicians = [{name: "jimmy blue", party: "democrat"},
          {name: "red guy", party: "republican"},
          {name: "terrance", party: "republican"},
          {name: "glenn coco", party: "democrat"}]
  all_voters = [{name: "silly bob", affiliation: "tea party"},
                {name: "happy johnny", affiliation: "liberal"},
                {name: "sad sandy", affiliation: "tea party"},
                {name: "joyous jill", affiliation: "liberal"},
                {name: "mellow mandy", affiliation: "neutral"},
                {name: "crazy craig", affiliation: "socialist"},
                {name: "boring bill", affiliation: "neutral"},
                {name: "radical randy", affiliation: "socialist"},
                {name: "luantic larry", affiliation: "conservative"},
                {name: "stayathome gunman", affiliation: "conservative"}]

  tea_party_probablity = {republican: 9, democrat: 1}
  world_sim = World.new(all_politicians,all_voters)
  world_sim.simulation
  puts "#{world_sim.votes.size} votes were counted"
  puts "The voter breakdown is:"
  puts "#{world_sim.tea_party_members.count} members of the Tea Party"
  puts "#{world_sim.conservatives.count} members of the Conservative Party"
  puts "#{world_sim.neutrals.count} members of the Neutral Party"
  puts "#{world_sim.liberals.count} members of the Liberal Party"
  puts "#{world_sim.socialists.count} members of the Socialist Party"
  puts "By popular vote, the new overlord of the universe is #{world_sim.overall_winner[0][:name].capitalize}!!!"

  if world_sim.democrats_on_ballot == [{name: "jimmy blue", party: "democrat"}, {name: "glenn coco", party: "democrat"}]
    puts "The democrats instance works"
  end
  if world_sim.republicans_on_ballot == [{name: "red guy", party: "republican"}, {name: "terrance", party: "republican"}]
    puts "The republicans instance works"
  end
end

test_simulation
