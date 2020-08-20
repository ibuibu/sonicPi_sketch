# Welcome to Sonic Pi v3.1

a = ring 4,4,2,2,4
a = [0.25,0.125,0.123,0.5].ring

live_loop :aa do
  idx = tick
  ##| a.tick.times do
  sample :sn_dolf
  sleep a[idx]
  ##| end
end
