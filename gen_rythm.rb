use_bpm 50

seq = []
be = 0
loop do
  if be % 64 == 0
    seq = [0]
    7.times do
      seq.push(rand_i(3))
    end
  end
  
  case seq[be% 8]
  when 0
    sample :bd_808
  when 1
    sample :sn_dolf, amp: 0.5
  end
  sample :drum_cymbal_closed, amp: 0.3*(2 - be%2)
  if be%64 == 0
    sample :drum_cymbal_soft
  end
  
  be = inc be
  sleep 0.25
end

