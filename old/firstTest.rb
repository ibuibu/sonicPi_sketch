define :my_loop do
  with_fx :reverb do
    with_fx :bitcrusher do
      with_fx :flanger do
        with_fx :wobble do
          use_synth :tb303
          sample :drum_bass_hard, rate: rrand(0.5, 2), amp: 5.0
          play choose(chord(:c4, :minor)), release: 0.8, amp: 0.3, cutoff: rrand(60, 130)
          sleep 0.25
        end
      end
    end
  end
end

in_thread(name: :looper) do
  loop do
    my_loop
  end
end