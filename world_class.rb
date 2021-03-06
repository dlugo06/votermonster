
# require_relative 'voter_module'
# require_relative 'c_person'
# include MainMenu
# include ClassPersonFactory

class World
  attr_accessor :republicans_on_ballot, :democrats_on_ballot, :tea_party_members, :conservatives, :neutrals, :liberals, :socialists, :overall_winner, :votes, :VOTER_ASSOCIATIONS, :politician_list

  def initialize
    #People type aggregate
    @voter_list = []
    @politician_list = []

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

  def politician_create(name, party)
    x = Politician.new(name, party)
    h = Hash.new
    h[:name] = x.name
    h[:party] = x.party
    @politician_list << h
  end

  def voter_create(name, affiliation)
    p v = Voter.new(name, affiliation) #gets information and transfers to appropriate list
    h = Hash.new
    h[:name] = v.name
    h[:affiliation] = v.affiliation
    @voter_list << h
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
