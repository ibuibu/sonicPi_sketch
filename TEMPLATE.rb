use_osc "localhost", 4565
use_bpm 60
use_random_seed 0

OSCMODE = true

live_loop :first_track do
  play!(OSCMODE, "melody", 70)
  sample!(OSCMODE, "drum", 60, :hh)
  sleep 1
end