# randomize
## snare and bassdrum
## sample
## //hh timming
## swing
## param

# fillin

# setting
use_osc "localhost", 4565
use_bpm 50
use_random_seed 7
OSCMODE = false

# sample names
bds = [:bd_ada, :bd_boom, :bd_fat, :bd_gas, :bd_haus, :bd_klub, :bd_mehackit, :bd_pure, :bd_sone, :bd_tek, :bd_zome, :bd_zum]
sns = [:drum_snare_hard, :drum_snare_soft, :elec_filt_snare, :elec_hi_snare, :elec_lo_snare, :elec_mid_snare, :elec_snare, :perc_snap, :perc_snap2, :sn_dolf, :sn_dub, :sn_generic, :sn_zome]
hhs = [:hh, :drum_cymbal_closed, :hhchirp, :hh909]

# global val
seq4 = []
bd_param_seq4 = []
sn_param_seq4 = []
be = 0
br = 0
sr = 0
hhr = 0
sw = 0
hh_interval = 2

# constant val
SEQLEN = 16
FOUR_MESURE_REPEAT_NUM = 2
# make sequense(randomize) timing
LEN = SEQLEN * 4 * FOUR_MESURE_REPEAT_NUM


define :make_seq do |seqlen, len, be|
  if be % LEN == 0
    seq = [0]
    (SEQLEN - 1).times do
      seq.push(rand_i(4))
    end

    bd_param_seq = []
    sn_param_seq = []
    SEQLEN.times do
      bd_param_seq.push([0.75 + rand(0.5), 0.5 + rand(1)])
      sn_param_seq.push([0.75 + rand(0.5), 0.9 + rand(0.2)])
    end
    
    seq4 = seq + seq + seq + seq
    bd_param_seq4 = bd_param_seq + bd_param_seq + bd_param_seq + bd_param_seq
    sn_param_seq4 = sn_param_seq + sn_param_seq + sn_param_seq + sn_param_seq
   
    # create fillin
    15.times do |i|
      seq4[i+49] = rand_i(3)
    end
    
    use_bpm rand_i(40) + 40
    br = rand_i(bds.length)
    sr = rand_i(sns.length)
    hhr = rand_i(hhs.length)
    sw = rand_i(6) * 0.01
    
    hh_interval = choose([1,2,4])
  end
end


live_loop :rythm do

  ##### MAKING #####
  make_seq(SEQLEN, LEN, be)
  
  ##### PLAY #####
  pos = be % (LEN/2)
  case seq4[pos]
  when 0 then
    sample bds[br], amp: bd_param_seq4[pos][0], rate: bd_param_seq4[pos][1]
  when 1 then
    sample sns[sr], amp: sn_param_seq4[pos][0], rate: sn_param_seq4[pos][1]
  end
  
  if be % hh_interval == 0
    sample hhs[hhr], amp: 1.3 - (0.3 * (be % 2)), rate: 0.5 + rand(2), pan: rand(2) - 1
  end
  
  if be % LEN == 0
    sample :drum_cymbal_hard
    sample choose(all_sample_names)
  end
  
  ##### ADJUST BEAT #####
  be = inc be
  
  if be % 2 == 0
    sleep 0.125 - sw
  else
    sleep 0.125 + sw
  end
  
end