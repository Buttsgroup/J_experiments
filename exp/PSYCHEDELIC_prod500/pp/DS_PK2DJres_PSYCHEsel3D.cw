;psychedelic3d
; written by Davy Sinnaeve, University of Manchester / Ghent University, 2015
; 2D J-resolved experiment using the Pell-Keeler method
; applying PSYCHE and selective pulses to evolve only selected couplings
; with homodecoupling of the unselected couplings
; run as 3D experiment
; written for Topspin 3.x
; Data can be reconstructed using pshift macro available at http://nmr.chemistry.manchester.ac.uk
;
;$CLASS=HighRes
;$DIM=3D
;$TYPE=
;$SUBTYPE=
;$COMMENT=

#include <Avance.incl>
#include <Delay.incl>
#include <Grad.incl>

define delay tauA
define delay tauB
define delay del_corr

"d0=0u"
"d10=0u"

"in0=inf1/2"
"in10=inf2/2"
"p2 = p1*2"
"tauA=in0/2" 																						;pure shift delays 1/2SW2
"tauB=dw*2*cnst4"							 												  ;drop points
"del_corr = tauA*0.5 + de - p1*2/PI" 										;compensation for chemical shift evolution during p1 and group delay

"l0=1" 																									;switch for Pell-Keeler

"cnst50=(cnst20/360)*sqrt((2*cnst21)/(p40/2000000))"  	;PSYCHE calculations
"p30=1000000.0/(cnst50*4)"
"cnst31= (p30/p1) * (p30/p1)"
"spw40=plw1/cnst31"
"p12=p40"

"cnst32=((p10/8)/p1)*((p10/8)/p1)"  								;BIP720 calculations
"spw15=plw1/cnst32"

"cnst2=cnst1*bf1" 																		;shape pulse offset calculations
"spoffs1=cnst2 - o1"



"acqt0=0"
baseopt_echo

aqseq 312

1 ze
2 50u
 20u LOCKH_OFF
 d1
 20u pl1:f1
 50u UNBLKGRAD
 p1 ph1
 del_corr pl0:f1 	; tauA*0.5 with corrections
 4u
 (p10:sp15 ph2):f1	; BIP pulse
 4u
 tauA*0.5

 if "l0 %2 == 0"	; R-type
 	{
 	d10 		; Jcoup evolution 2DJ
 	}

  4u
  p11:sp1:f1 ph3:r 	; sel. 180 pulse on spin S
  4u

  d0 			; chemical shift evolution

 tauA*0.5
 4u
 (p10:sp15 ph2):f1 	; BIP pulse
 4u
 tauA*0.5

 if "l0 %2 == 1" 	; N-type
	 {
 	d10		; Jcoup evolution 2DJ
	 }

 tauB			 ; extra delay for drop points
 p16:gp1
 d16
 d16
 ( center (p40:sp40 ph3):f1 (p12:gp12) ) ; PSYCHE
 d16
 p16:gp1
 d16

 4u BLKGRAMP
 (p10:sp15 ph4):f1 	; BIP pulse
 4u

 if "l0 %2 == 0"	; R-type
	 {
 	d10 		; Jcoup evolution 2DJ
	 }

 4u
 p11:sp1:f1 ph4:r 	; sel. 180 pulse on spin S
 4u

 4u
 (p10:sp15 ph4):f1 	; BIP pulse
 4u pl1:f1

 if "l0 %2 == 1" 	; N-type
 	{
 	d10 		; Jcoup evolution 2DJ
 	}

 d0 			; chemical shift evolution

 go=2 ph31
 50u mc #0 to 2 
   F1QF(caldel(d0,+in0)) 			; pure shift
   F2EA(calclc(l0,1), caldel(d10,+in10)) 	; 2D Jres
 20u LOCKH_OFF
exit

ph1 = {0}*4 {2}*4
ph2 = {0}*8 {2}*8
ph3 = 0 1 2 3
ph4 = {0}*16 {2}*16

ph31= -ph1 + ph3*2

;pl0: 0 W
;pl1 : f1 channel - power level for pulse (default)
;p1 : f1 channel - high power 90 pulse
;p2 : f1 channel - high power 180 pulse
;p10: BIP 720 pulse duration
;p11: sel. 180 pulse width for spin S
;p16: CTP gradient pulse duration
;p45: duration of PSYCHE double chirp
;d1 : relaxation delay; 1-5 * T1
;d16: [1ms] delay for homospoil/gradient recovery
;cnst1: Chemical shift of selective pulse (in ppm)
;cnst2: Frequency shift of selective pulse (in Hz)
;cnst4: number of points to drop when collecting FID
;cnst20: desired flip angle for PSYCHE pulse element (degree) (normally 10-25) 
;cnst21: bandwidth of each chirp in PSYCHE pulse element (Hz) (normally 10000)
;cnst50: desired PSYCHE RF field for chirp pulse in Hz
;NS: 4 * n, total number of scans: NS * TD0
;FnMODE: QF in F1
;FnMODE: Echo-Antiecho in F2

;sp1: (spin S) selective pulse power level
;spoffs1: (spin S) selective pulse offset
;spnam1: (spin S) file name for selective pulse
;sp40: (PSYCHE) power level of chirp element (calculated from cnst21)
;spoffs40: (PSYCHE) selective pulse offset (0 Hz)
;spnam40: (PSYCHE) file name for selective pulse
;sp15: BIP pulse power level (calculated from plw1 and p1)
;spnam15: BIP720,50,20.1

; for z-gradients only
;gpz1: 20%
;gpz12: PSYCHE

;use gradient files: 
;gpnam1: SMSQ10.100
;gpnam12: RECT.1

;swh in F3 is an integer multiple of swh in F1
;swh in F3 is a power of 2 multiple of swh in F2
