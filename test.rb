use_osc "localhost", 4565
use_bpm 60
use_random_seed 0

OSCMODE = true

live_loop :an do
  # play!(OSCMODE, "drum", 70)
  sample!(OSCMODE, "drum", 70, :hh)
  sleep 1
end