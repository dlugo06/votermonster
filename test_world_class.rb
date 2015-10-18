require_relative "world_class"

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
