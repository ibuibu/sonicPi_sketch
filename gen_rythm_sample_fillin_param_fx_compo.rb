# randomize
## snare and bassdrum
## sample
## swing
## param
## compo

# fillin

# setting
use_osc "localhost", 4565
use_bpm 50
use_random_seed 17
OSCMODE = false

TRACK_NUM = 5
states = initTrackStates(TRACK_NUM) 


# global val
bds = [:bd_ada, :bd_boom, :bd_fat, :bd_gas, :bd_haus, :bd_klub, :bd_mehackit, :bd_pure, :bd_sone, :bd_tek, :bd_zome, :bd_zum]
sds = [:drum_snare_hard, :drum_snare_soft, :elec_filt_snare, :elec_hi_snare, :elec_lo_snare, :elec_mid_snare, :elec_snare, :perc_snap, :perc_snap2, :sn_dolf, :sn_dub, :sn_generic, :sn_zome]
hhs = [:hh, :drum_cymbal_closed, :hhchirp, :hh909]
backings =[:prophet, :beep]
melos = [:pluck, :piano]
nums = initTrackStates(TRACK_NUM) 
lens = [bds.length, sds.length, hhs.length, backings.length, melos.length]

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

con = [0,1,2,3,4,5,6].ring
c = 0
cho = []
choten = 0
r = 0

tenten = 0

ROOT = 40

# constant val
SEQLEN = 16
FOUR_MESURE_REPEAT_NUM = 8
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
    nums[0] = rand_i(bds.length)
    nums[1] = rand_i(sds.length)
    nums[2] = rand_i(hhs.length)
    swing = rand_i(6) * 0.01
    hh_interval = choose([1,2,4])
  end
end


live_loop :rythm do

  with_fx fxs[fxs_num], pre_mix: prm, reps: 16 do
    pos = be % (LEN/FOUR_MESURE_REPEAT_NUM)
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

    ##### ON/OFF #####
    if be % 32 == 0
      puts states
      if states.count(0) != 0 
        if one_in(2)
          target = random_choice(0, states)
          states[target] = 1
        end
      end
      if states.count(1) >= 2
        if one_in(4)
          target = random_choice(1, states)
          states[target] = 0
          nums[target] = rand_i(lens[target])
        end
      end
    end
    
    ##### PLAY #####
    case seq4[pos]
    when 0 then
      sample bds[nums[0]], amp: bd_param_seq4[pos][0] * states[0], rate: bd_param_seq4[pos][1]
    when 1 then
      sample sds[nums[1]], amp: sd_param_seq4[pos][0] * states[1], rate: sd_param_seq4[pos][1], pan: sd_param_seq4[pos][2]
    end
    
    if be % hh_interval == 0
      sample hhs[nums[2]], amp: 1.3 - (0.3 * (be % 2)) * states[2], rate: 0.5 + rand(2), pan: hh_pan
    end
    
    if be % LEN == 0
      sample :drum_cymbal_hard
    end

    if be % 64 == 0
      use_synth :piano
      r = rrand(0,3).to_i
      m = diatonic_chords7(ROOT)
      c = c - 4
      cho = m[con[c]]
      choten = add_random_tension(ROOT, cho)
      tenten = inversion(choten, r)
    end

    if be % 16 == 0
      use_synth backings[nums[3]]
      play tenten, amp: states[3], release: 2, attack: 0.5
    end

    if be % rrand_i(1,4) == 0
      use_synth melos[nums[4]]
      play choose(tenten), amp: 0.5 * states[4]
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