def candenza
  t = [0,2,4]
  s = [1,3]
  d = [4,6]
  tst = [t.choose,s.choose,t.choose,t.choose].ring
end



def chordgen(rt)
  r = rand_i(3)
  if r == 0 then
    a = [rt,rt+2,rt+4]
  elsif r == 1 then
    a = [rt+2,rt+4,rt+7]
  elsif r == 2 then
    a = [rt-3,rt+2,rt+4]
  end
  return a
end

loop do
  puts chordgen(0)
  sleep 1
end
