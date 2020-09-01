define :major do |n|
  return [n, n+4, n+7]
end

define :minor do |n|
  return [n, n+3, n+7]
end

define :mb5 do |n|
  return [n, n+3, n+6]
end

define :major7 do |n|
  return major(n).push(n+11)
end

define :minor7 do |n|
  return minor(n).push(n+10)
end

define :dom7 do |n|
  return major(n).push(n+10)
end

define :m7b5 do |n|
  return mb5(n).push(n+10)
end

define :add_random_tension do |key, chord|
  ten = {"9" => 14, "11" => 17, "#11" => 18, "b13" => 20, "13" => 21}
  deg = chord[0] - key
  t = 0
  case deg
  when 0 then
    r = rand_i(2)
    if r == 0 then
      t = ten["9"]
    else
      t = ten["13"]
    end
  when 2 then
    r = rand_i(3)
    if r == 0 then
      t = ten["9"]
    elsif r == 1 then
      t = ten["11"]
    else
      t = ten["13"]
    end
  when 4 then
    t = ten["11"]
  when 5 then
    r = rand_i(3)
    if r == 0 then
      t = ten["9"]
    elsif r == 1 then
      t = ten["#11"]
    else
      t = ten["13"]
    end
  when 7 then
    r = rand_i(2)
    if r == 0 then
      t = ten["9"]
    else
      t = ten["13"]
    end
  when 9 then
    r = rand_i(2)
    if r == 0 then
      t = ten["9"]
    else
      t = ten["11"]
    end
  when 11 then
    r = rand_i(2)
    if r == 0 then
      t = ten["11"]
    else
      t = ten["b13"]
    end
  end
  tension = chord[0] + t
  return chord.push(tension)
end

define :major_roots do |n|
  roots = [0, 2, 4, 5, 7, 9, 11]
  return roots.map { |i| n+i }
end

define :diatonic_chords do |n|
  return [major(n), minor(n+2), minor(n+4), major(n+5), major(n+7), minor(n+9), mb5(n+11)]
end

define :diatonic_chords7 do |key|
  return [major7(key), minor7(key+2), minor7(key+4), major7(key+5), dom7(key+7), minor7(key+9), m7b5(key+11)]
end

define :inversion do |chord, target|
  if target > chord.length then
    puts 'error'
    return
  end
  target.times do |i|
    chord[i] = chord[i] + 12
  end
  return chord
end

define :play! do |is_osc=false, msg=nil, note|
  if is_osc
    if note.instance_of?(Array)
      osc msg + ' ' + note.to_s.gsub!(/\[|\]|,/, '')
    elsif note.instance_of?(Integer)
      osc msg + ' ' + note.to_s
    else
      puts 'error in play_or_osc'
    end
  else
    play note
  end
end

define :sample! do |is_osc=false, msg=nil, note, smpl|
  if is_osc
    osc msg + ' ' + note.to_s
  else
    sample smpl
  end
end

define :initTrackStates do |n|
  array = [0]
  (n - 1).times do
    array += [0]
  end
  return array
end

define :random_choice do |n, states|
  indexes = []
  (0..states.length).each do |index|
    if states[index] == n
      indexes.push(index)
    end
  end
  target = indexes.shuffle[0]
  return target
end
