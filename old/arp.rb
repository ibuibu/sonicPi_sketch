counter = 0
live_loop :arp do
  with_fx :reverb do
    #with_fx :bitcrusher do
    #with_fx :flanger do
    #with_fx :echo do
    sample :drum_cymbal_soft, rate: rrand(0.25, 2), amp: rrand(0.8,1.3), pan: rrand(-1,1)
    sample :bd_haus, amp: rrand_i(0,3)
    play (scale :c3, :major_pentatonic)[counter], release: 0.2
    play (scale :g3, :minor_pentatonic)[counter], release: 0.2
    play (scale :e3, :minor_pentatonic)[counter], release: 0.1, pan: rrand(-1,1)
    #end
    #end
    #end
  end
  counter += 1
  sleep 0.125
end
