class Beat
  @@bd_samples = [:bd_ada, :bd_boom, :bd_fat, :bd_gas, :bd_haus, :bd_klub, :bd_mehackit, :bd_pure, :bd_sone, :bd_tek, :bd_zome, :bd_zum]
  @@sd_samples = [:drum_snare_hard, :drum_snare_soft, :elec_filt_snare, :elec_hi_snare, :elec_lo_snare, :elec_mid_snare, :elec_snare, :perc_snap, :perc_snap2, :sn_dolf, :sn_dub, :sn_generic, :sn_zome]
  @@hh_samples = [:hh, :drum_cymbal_closed, :hhchirp, :hh909]

  def initialize
    self.change_sample
    @sequense_length = 16
    @hh_interval = 2
    @sequense = []
  end

  def pos(be)
    return be % (@sequense_length * 4)
  end

  def change_sample
    bd_sample_num = rand(@@bd_samples.length)
    sd_sample_num = rand(@@sd_samples.length)
    hh_sample_num = rand(@@hh_samples.length)
    @bd_sample = @@bd_samples[bd_sample_num]
    @sd_sample = @@sd_samples[sd_sample_num]
    @hh_sample = @@hh_samples[hh_sample_num]
  end

  def make_sequense
    temp_seq = [0]
    (@sequense_length - 1).times do
      temp_seq.push(rand(4))
    end
    @sequense = temp_seq

    @hh_interval = [1, 2, 4, 8].sample
  end

  def make_sequense_fillin
    self.make_sequense()
    @sequense = @sequense + @sequense + @sequense + @sequense
    15.times do |i|
      @sequense[i+49] = rand(3)
    end
  end

  def make_params
    bd_temp = []
    sd_temp = []
    @sequense_length.times do
      # [amp, rate]
      bd_temp.push([0.75 + Random.rand(0.5), 0.5 + Random.rand])
      sd_temp.push([0.75 + Random.rand(0.5), 0.9 + Random.rand(0.2)])
    end
    @bd_params = bd_temp + bd_temp + bd_temp + bd_temp
    @sd_params = sd_temp + sd_temp + sd_temp + sd_temp
    
    temp = []
    weak = 0.3 + Random.rand(0.5)
    (64 / @hh_interval).times do
      temp.push(1)
      (@hh_interval - 1).times{ temp.push(0) }
      temp.push(weak)
      (@hh_interval - 1).times{ temp.push(0) }
    end
    @hh_params = temp
  end

  attr_accessor :bd_sample, :sd_sample, :hh_sample, :sequense, :sequense_length, :bd_params, :sd_params, :hh_interval, :hh_params

end

def iffunc(be, n, &func)
  if be % n == 0
    func.call()
  end
end

b = Beat.new()

be = 0
live_loop :a do
  iffunc(be, 128) {
    b.make_sequense_fillin
    b.make_params
    b.change_sample
  }
  pos = b.pos(be)
  case b.sequense[pos]
  when 0 then
    sample b.bd_sample, amp: b.bd_params[pos][0], rate: b.bd_params[pos][1]
  when 1 then
    sample b.sd_sample, amp: b.sd_params[pos][0], rate: b.sd_params[pos][1]
  end
  iffunc(be, b.hh_interval) { sample b.hh_sample, amp: b.hh_params[pos]}

  sleep 0.125
  be += 1
end