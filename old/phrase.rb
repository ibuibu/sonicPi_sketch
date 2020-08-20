#phrase make

##| a = [1,2]
##| sum = 0
##| a.each { |i| sum += i }
##| puts sum



##| def  phraseplot
##|   a = []
##|   r = 0
##|   3.times do
##|     r = 2**-(rand_i(4)+1)
##|     a.push(r.to_f)
##|   end
##|   return a
##| end

##| puts phraseplot()


#合計が１になるまで。。。はみ出たら、最後の要素を、ちょうどになるまで/2する
def phrase
  a = []
  sum = 0
  while sum <= 1 do
      r = 2**-(rand_i(4)+1)
      a.push(r.to_f)
      sum = a.inject(:+)
      #end
    end
    
    while sum != 1 do
        a.push(a.pop/2)
        sum = a.inject(:+)
        #end
      end
      return a.ring
    end
    
    pp = phrase()
    puts pp
    
    live_loop :aa do
      idx = tick
      ##| a.tick.times do
      sample :sn_dolf
      sleep pp[idx]
      ##| end
    end
    
    live_loop :qw do
      sample :bd_boom
      sleep 1
    end
    
    live_loop :aa do
      aa = tick % 4
      if aa == 0
        pp = phrase()
      end
    end
    