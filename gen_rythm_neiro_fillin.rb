# randomize
## snare and bassdrum
## sample
## //hh timming
## swing

# fillin

use_bpm 50
use_random_seed 3

bds = [:bd_ada, :bd_boom, :bd_fat, :bd_gas, :bd_haus, :bd_klub, :bd_mehackit, :bd_pure, :bd_sone, :bd_tek, :bd_zome, :bd_zum]
sns = [:drum_snare_hard, :drum_snare_soft, :elec_filt_snare, :elec_hi_snare, :elec_lo_snare, :elec_mid_snare, :elec_snare, :perc_snap, :perc_snap2, :sn_dolf, :sn_dub, :sn_generic, :sn_zome]
hhs = [:hh, :drum_cymbal_closed, :hhchirp, :hh909]

seq = []
seq4 = []
seq8 = []
be = 0
br = 0
sr = 0
hhr = 0
sw = 0

LEN = 128
SEQLEN = 16

hh_interval = 2

loop do
  if be % LEN == 0
    seq = [0]
    (SEQLEN - 1).times do
      seq.push(rand_i(4))
    end
    
    seq4 = seq + seq + seq + seq
    
    15.times do |i|
      seq4[i+49] = rand_i(3)
    end
    
    seq8 = seq4 + seq4
    
    use_bpm rand_i(40) + 40
    br = rand_i(bds.length)
    sr = rand_i(sns.length)
    hhr = rand_i(hhs.length)
    sw = rand_i(6) * 0.01
    
    hh_interval = choose([1,2,4])
  end
  
  case seq8[be % LEN]
  when 0 then
    sample bds[br]
  when 1 then
    sample sns[sr], amp: 0.8
  end
  
  if be % hh_interval == 0
    sample hhs[hhr], amp: 1.3 - (0.3 * (be % 2))
  else
    #  if one_in(6)
    #   sample hhs[hhr], amp: 1.3 - (0.3 * (be % 2))
    #end
  end
  
  if be % LEN == 0
    sample :drum_cymbal_hard
  end
  
  be = inc be
  
  if be % 2 == 0
    sleep 0.125 - sw
  else
    sleep 0.125 + sw
  end
  
end