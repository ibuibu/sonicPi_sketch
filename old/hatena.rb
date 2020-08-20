live_loop :foo do
  sample :bd_sone, rate: rrand(0.4,1.9), amp: rrand(0.3,1.0)
  sleep choose([0.25,0.5,0.75])
end

live_loop :bass do
  sample :glitch_bass_g
  sleep choose([2,4])
end

live_loop :hihat_loop do
  divisors = ring 2, 4, 2, 5
  divisors.tick.times do
    sample choose([:drum_cymbal_closed])
    sleep 0.5 / divisors.look
  end
end

live_loop :glitch do
  sample choose([:glitch_perc1, :glitch_perc2, :glitch_perc3, :glitch_perc4,nil]), rate: rrand(0.5,1.5)
  sleep choose([0.25,0.5,0.75])
end

live_loop :bar do
  sync :foo
  sample :ambi_piano, rate: rrand(0.5,1.4)
  sleep 2
end

