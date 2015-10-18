class Test
  require_relative 'world_class'
  require 'faker'

  def initialize
    @all_politicians
    @all_voters
  end

  def create_all_voters(t, c, n, l, s)
    names = (t+l+n+s+c).times.map {Faker::Name.name}
    all = []
    all << Array.new(t, "tea party")
    all << Array.new(l, "liberal")
    all << Array.new(n, "neutral")
    all << Array.new(s, "socialist")
    all << Array.new(c, "conservative")
    all.flatten!
    keys = [:name, :affiliation]
    values = []
    names.each_with_index.map do |name, index|
      values << [name, all[index]]
    end
    @all_voters = values.map{|r| Hash[r.zip(keys)].invert }
  end

  def create_all_politicians(reps, dems)
    names = (reps+dems).times.map {Faker::Name.name}
    keys = [:name, :party]
    all = []
    all << Array.new(reps, "republican")
    all << Array.new(dems, "democrat")
    all.flatten!
    values = []
    names.each_with_index.map do |name, index|
      values << [name, all[index]]
    end
    @all_politicians = values.map{|r| Hash[r.zip(keys)].invert }
  end

  def test_simulation
    world_sim = World.new(@all_politicians, @all_voters)
    world_sim.simulation
    puts "#{world_sim.votes.size} votes were counted"
    puts "The voter breakdown is:"
    puts "#{world_sim.tea_party_members.count} members of the Tea Party"
    puts "#{world_sim.conservatives.count} members of the Conservative Party"
    puts "#{world_sim.neutrals.count} members of the Neutral Party"
    puts "#{world_sim.liberals.count} members of the Liberal Party"
    puts "#{world_sim.socialists.count} members of the Socialist Party"
    puts "By popular vote, the new overlord of the universe is #{world_sim.overall_winner[0][:name].capitalize} of the #{world_sim.overall_winner[0][:party].capitalize} Party!!!"
  end
end

test_1 = Test.new
test_1.create_all_politicians(15, 6)
test_1.create_all_voters(3405, 252, 5424, 126, 3405)
test_1.test_simulation
