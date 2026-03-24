# PSYCHEDELIC

Selective $J$-res experiment, with $^{2/3}J_{HH}$ resolved in F1.

## Usage
1. Run a selective gradient $^{1}$H excitation
2. Create new experiment for PSYCHEDELIC
3. Transfer the following parameters across:

| selGrad | | PSYCHEDELIC |
|:-------:||:-----------:|
|  CNST21 | -> |    CNST1    |
|   P12   | -> |     P11     |
|   SPW2  | -> |     SPW1    |

4. Run the experiment
5. Process with pshift/tilt (or use provided AU macro)
