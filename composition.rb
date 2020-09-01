define :initTrackStates do |n|
  array = [0]
  (n - 1).times do
    array += [0]
  end
  return array
end

define :random_choice do |n, states|
  indexes = []
  (0..states.length).each do |index|
    if states[index] == n
      indexes.push(index)
    end
  end
  target = indexes.shuffle[0]
  return target
end




TRACK_NUM = 3
states = initTrackStates(TRACK_NUM) 

choices = (0..states.length-1).to_a.shuffle
n = 0

bds = [:bd_ada, :bd_boom, :bd_fat, :bd_gas, :bd_haus, :bd_klub, :bd_mehackit, :bd_pure, :bd_sone, :bd_tek, :bd_zome, :bd_zum]
sds = [:drum_snare_hard, :drum_snare_soft, :elec_filt_snare, :elec_hi_snare, :elec_lo_snare, :elec_mid_snare, :elec_snare, :perc_snap, :perc_snap2, :sn_dolf, :sn_dub, :sn_generic, :sn_zome]
hhs = [:hh, :drum_cymbal_closed, :hhchirp, :hh909]
nums = [0,0,0]
be = 0

use_bpm 100

live_loop :bd do
  puts states
  if be % 8 == 0
    # if n < states.length
    #   states[choices[n]] = 1
    #   puts states[choices[n]], 'add'
    #   n += 1
    # end
    
    if states.count(1) >= 2
      if one_in(4)
        target = random_choice(1, states)
        states[target] = 0
        nums[target] = rand_i(4)
      end
    end
    
    if states != [1,1,1]
      if one_in(2)
        target = random_choice(0, states)
        states[target] = 1
      end
    end
    
  end
  be += 1
  sample bds[nums[0]], amp: states[0]
  sleep 1
end

live_loop :hh do
  sync :bd
  sample hhs[nums[1]], amp: states[1]
  sleep 0.2499
  sample hhs[nums[1]], amp: states[1]
  sleep 0.2499
end

live_loop :sd do
  sync :bd
  sleep 0.5
  r = choose(chord(:E3, :madd13))
  sample sds[nums[2]], amp: states[2]
  sleep 0.2499
end
