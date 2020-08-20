ka = [chord(:A3, :minor),chord(:D3, :minor),chord(:G3, :major),chord(:C3, :major)].ring
#‘¼‚ÌŠyŠí‚Æ‹¤—L‚·‚é‚É‚ÍH

aa = 0

live_loop :arp do
  #play (scale :e3, :minor_pentatonic).tick, release: 0.1
  play ka.tick
  aa = ka[look]
  sleep 1
end

live_loop :arp2 do
  use_synth :prophet
  play ([aa[0],aa[1],aa[2]].choose + 12) #minus‚ª‚Å‚«‚È‚¢
  puts [aa[0],aa[1],aa[2]].choose.class
  sleep 0.25
end


##| live_loop :arp2 do
##|   use_synth :dsaw
##|   play (scale :e2, :minor_pentatonic, num_octaves: 3).tick, release: 0.25
##|   sleep 0.25
##| end