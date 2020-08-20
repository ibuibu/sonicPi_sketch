
def keygen(key)
  k = [0,2,4,5,7,9,11]
  a = []
  3.times do |i|
    a.push(k.each_with_object(key+i*12).map(&:+))
  end
  return a.flatten!
end

k = keygen(60)
kb = keygen(48)


live_loop :bass do
  use_synth :fm
  play kb.choose, amp: 0.7
  sleep 0.25
end

live_loop :piano do
  use_synth :piano
  r = (0..12).to_a.sort_by{rand}[0..2]
  play [k[r[0]],k[r[1]]], amp: 3
  puts [k[r[0]],k[r[1]]]
  sleep 0.5
end

live_loop :bd do
  sample :bd_haus
  sleep [1,0.5].choose
end

live_loop :hat do
  sample :drum_cymbal_closed, amp: rand, pan: rand
  sleep [0.25,0.125].choose
end
