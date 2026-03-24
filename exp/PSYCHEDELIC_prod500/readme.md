# PSYCHEDELIC

Selective $J$-res experiment, with $^{2/3}J_{HH}$ resolved in F1.

## Usage
1. Run a selective gradient $^{1}$H excitation
2. Create new experiment for PSYCHEDELIC
3. Transfer the following parameters across:

| Parameter description             | selGrad | > | PSYCHEDELIC |
|-----------------------------------|---------|---|-------------|
| Chemical shift of selective pulse | CNST21  | > | CNST1       |
| 180 $^{\circ}$ pulse width        | P12     | > | P11         |
| 180 $^{\circ}$ pulse power        | SPW2    | > | SPW1        |

4. Run the experiment

## Processing
Process with `pshift` AU macro from University of Manchester, then `tilt` (or use provided AU macro). Processed spectrum will appear as 1000 + exp_no

## Analysis
- No coupling will appear as a singlet along 0 Hz
- Any homonuclear coupling will resolve as a doublet in F1
- Selected frequency will fold into spectrum in F1