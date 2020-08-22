use_bpm 50

KEY = 2

chords = [chord(:C2, :major7), chord(:D2, :minor7), chord(:E2, :minor7), chord(:F2, :major7), \
          chord(:G2, '7'), chord(:A2, :minor7), chord(:B2, 'm7b5'),\
          chord(:C3, :major7), chord(:D3, :minor7), chord(:E3, :minor7), chord(:F3, :major7), \
          chord(:G3, '7'), chord(:A3, :minor7), chord(:B3, 'm7b5'),\
          ]

chords = chords.map { |i| i + KEY }
chords = chords.ring

counter = 0
live_loop :backing do
  use_synth :piano
  play chords[counter], release: 2.0, amp: 3
  sleep 1.0
  counter = counter - 4
end
live_loop :melody do
  sync :backing
  use_synth :piano
  play choose(chords[counter] + 12),amp: 0.8
  sleep choose([0.125,0.25])
  play choose(chords[counter] + 12),amp: 0.8
  sleep choose([0.125,0.25,0.5])
  play choose(chords[counter] + 12),amp: 0.8
  sleep choose([0.125,0.25,0.5])
  play choose(chords[counter] + 12),amp: 0.8
end