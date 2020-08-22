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
use_random_seed 15
OSCMODE = false

# global val
bds = [:bd_ada, :bd_boom, :bd_fat, :bd_gas, :bd_haus, :bd_klub, :bd_mehackit, :bd_pure, :bd_sone, :bd_tek, :bd_zome, :bd_zum]
sds = [:drum_snare_hard, :drum_snare_soft, :elec_filt_snare, :elec_hi_snare, :elec_lo_snare, :elec_mid_snare, :elec_snare, :perc_snap, :perc_snap2, :sn_dolf, :sn_dub, :sn_generic, :sn_zome]
hhs = [:hh, :drum_cymbal_closed, :hhchirp, :hh909]
bd_num, sd_num, hh_num = 0, 0, 0
seq4 = []
bd_param_seq4 = []
sd_param_seq4 = []
hh_pan = 0
be = 0
swing = 0
hh_interval = 2
fxs = [:reverb, :lpf, :distortion, :bitcrusher, :ixi_techno, :octaver, :ring_mod, :reverb, :pitch_shift]
fxs_num = 0
prm = 0
fxtiming = nil

# constant val
SEQLEN = 16
FOUR_MESURE_REPEAT_NUM = 2
# make sequense(randomize) timing
LEN = SEQLEN * 4 * FOUR_MESURE_REPEAT_NUM

define :make_seq do |seqlen, len, be|
  if be % len == 0
    seq = [0]
    (seqlen - 1).times do
      seq.push(rand_i(4))
    end

    bd_param_seq = []
    sn_param_seq = []
    sd_pan = rand(2) - 1
    hh_pan = -(sd_pan)
    SEQLEN.times do
      # [amp, rate, pan]
      bd_param_seq.push([0.75 + rand(0.5), 0.5 + rand(1)])
      sn_param_seq.push([0.75 + rand(0.5), 0.9 + rand(0.2), sd_pan])
    end
    
    seq4 = seq + seq + seq + seq
    bd_param_seq4 = bd_param_seq + bd_param_seq + bd_param_seq + bd_param_seq
    sd_param_seq4 = sn_param_seq + sn_param_seq + sn_param_seq + sn_param_seq
   
    # create fillin
    15.times do |i|
      seq4[i+49] = rand_i(3)
    end
    
    use_bpm rand_i(40) + 50
    bd_num = rand_i(bds.length)
    sd_num = rand_i(sds.length)
    hh_num = rand_i(hhs.length)
    swing = rand_i(6) * 0.01
    hh_interval = choose([1,2,4])
  end
end


live_loop :rythm do

  with_fx fxs[fxs_num], pre_mix: prm, reps: 16 do
    pos = be % (LEN/2)
    if pos == 0
      fxtiming = choose([31,47])
    elsif pos == fxtiming 
      fxs_num = rand_i(fxs.length)
      prm = 1
    elsif pos == 63
      prm = 0
    end
    
    ##### MAKING #####
    make_seq(SEQLEN, LEN, be)
    
    ##### PLAY #####
    case seq4[pos]
    when 0 then
      sample bds[bd_num], amp: bd_param_seq4[pos][0], rate: bd_param_seq4[pos][1]
    when 1 then
      sample sds[sd_num], amp: sd_param_seq4[pos][0], rate: sd_param_seq4[pos][1], pan: sd_param_seq4[pos][2]
    end
    
    if be % hh_interval == 0
      sample hhs[hh_num], amp: 1.3 - (0.3 * (be % 2)), rate: 0.5 + rand(2), pan: hh_pan
    end
    
    if be % LEN == 0
      sample :drum_cymbal_hard
    end
    
    ##### ADJUST BEAT #####
    be = inc be
    
    if be % 2 == 0
      sleep 0.125 - swing
    else
      sleep 0.125 + swing
    end
  end
  
end