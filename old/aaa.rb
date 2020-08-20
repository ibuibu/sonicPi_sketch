live_loop :foo do
  with_fx :reverb do
    sample :bd_808, amp: 4
    use_synth :supersaw
    play choose(chord(:a3, :m7)), attack: 0, sustain: 0.2, release: 0, cutoff: rrand(90,130), pan: rrand(-1, 1)
    sleep choose([2,4,6])*0.1
  end
end

live_loop :bar do
  #sync :foo
  sample :bd_zome
  sleep 1
end
