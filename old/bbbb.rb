counter = 0
live_loop :arp do
  with_fx :reverb do
    with_fx :bitcrusher do
      #with_fx :flanger do
      #with_fx :echo do
      sample :drum_cymbal_soft, rate: rrand(0.25, 4), amp: rrand(0.9,1.4), pan: rrand(-1,1)
      sample :bd_haus, amp: rrand_i(0,4)
      use_synth :dpulse
      play (scale :c3, :major_pentatonic)[counter], release: rrand(0.1,0.2), pan: rrand(-1,1), amp: rrand(0.5,1.5)
      play (scale :g4, :minor_pentatonic).shuffle.tick, release: 0.15, amp: rrand(0.5,1.5)
      play (scale :e3, :minor_pentatonic)[counter], release: 0.1, pan: rrand(-1,1), amp: rrand(0.5,1.5)
      #end
      #end
    end
  end
  counter += 1
  sleep 0.125
end
