# Arg List and Click List

## Collision Sheel
+ https://forums.eagle.ru/topic/80600-gear-state-external-flight-model-source-problem-identified/page/2/?tab=comments#comment-1742904

## Screen Helper
+ VDI- Center/Right/Down : pilot Vdi

## Main Control
#### ARG 21 - 23
+ 21: Roll
+ 22: Pitch
#### ARG 38
+ Canopy open/close
#### ARG 41-44
+ 41: Left Throttle
+ 42: Right Throttle
+ 43: Flap Handle [Helper: "FLAP_LEVEL"]
+ 44: Tow link handle
#### ARG 50-52
+ 50: landing gear handle [Helper: "PNT_083"]
+ 51: emergency break
+ 52: parking break (rotate) [Helper: "PARKING_BREAK"]
+ 53: hook_handle [Helper: "PTN_053"]
----

## left panel
#### ARG 101 - 107
+ fuel gauge display selection button
+ from back to front (101 to 107)

#### ARG 108 - 113
+ generator and fuel conrol panel switch
+ helper: PTN_108 to PTN_114
+ 108: L_GEN
+ 109: L_SPD_DR
+ 110: R_SPD_DR
+ 111: R_GEN
+ 112: L_Fuel
+ 113: R_Fuel

#### ARG 114 - 117
+ bleed air system
+ 114: nww auto
+ 115: CSD
+ 116: AIR cond
+ 117: all close

#### ARG 118 - 119 [150 151 now]
+ Left Engine Crank (118)
+ Right Engine Crank (119)

#### ARG 120 - 123
+ 120: flaperon pop up 
+ 121: anti skid
+ 122: APC [cold/std/hot]
+ 123: APC [engage/stby/off]

#### ARG 124 - 134
+ 124: collision
+ 125: Taxi, Prob light
+ 126: Key LT
+ 127: Key
+ 128: Tail
+ 129: WING
+ 130: Formation
+ 131: Flood
+ 132: Instruments
+ 133: Console
+ 134: Approach Index

#### ARG 135 - 144
##### 135 - 139 HDI Display
+ 135: OFF
+ 136: STBY
+ 137: TC CAL
+ 138: TC
+ 139: CONT ANALOG
##### 140 - 144 RANGE MILES
+ 140: TEST
+ 141: 1 miles
+ 142: 1.5 miles
+ 143: 2 miles
+ 144: 3 mils

#### ARG 145 - 149
+ 145: Tank Press
+ 146: Wing drop tank trans
+ 147: Wing tank dump
+ 148: fuselarge tank dump
+ 149: Fuel ready
+ 118: Boost Pump Test

#### ARG 152 - 158
+ hud
+ hud moveable reticles: 152
+ hud main control: 153
+ hud fixed reticles: 154
+ hud TEST: 155
+ reticles brightness: 156
+ in range brightness: 157
+ breakaway brightness: 158

#### ARG 159 - 163
+ VDI
+ 159: vdi brightness
+ 160: contrast ratio of target
+ 161: pitch trim
+ 162: oFFSET imp pt
+ 163: path brightness

#### ARG 164 - 171
+ RADAR
+ 164: power switch of display
+ 165: brightness
+ 166: contrast
+ 167: altitude ref
+ 168: RNG mark control
+ 169: AZ mark control
+ 170: presist
+ 171: one scan and ease control

#### ARG 172 - 177
+ Auto Pilot Control Panel
+ 172: ON OFF
+ 173: AUTO STBY
+ 174: CMD
+ 175: ALT hold
+ 176: Return to Level
+ 177: Mach Hold

#### ARG 178 - 183
+ UHF COMM
+ 178: COMM mode 
+ 179: UHF Channel 1
+ 180: UHF Channel 2
+ 181: UHF Channel 3
+ 182: GUARD XMIT
+ 183: Volume

#### ARG 184 - 190
+ TACAN Conrol
+ 184: Mode
+ 185: Channel 1
+ 186: Channel 2
+ 187: Channel x100 display
+ 188: Channel x10 display
+ 189: Channel x1 display
+ 190: VOL control/button (not sure)

#### ARG 191 - 208
+ IFF Panel
+ 191: Code Roller
+ 192: Reply Button
+ 193: Test Button
+ 194: Master Switch
+ 195: Audio Switch
+ 196: Test M-1
+ 197: Test M-2
+ 198: Test M-3/A
+ 199: Test M-C
+ 200: RAD Test
+ 201: Mode 4 Switch
+ 202: Mode 1 First Roller
+ 203: Mode 1 Second Roller
+ 204: Mode 3/A Fiest Roller
+ 205: Mode 3/A Second Roller
+ 206: Mode 3/A Third Roller
+ 207: Mode 3/A Fourth Roller
+ 208: IDENT Mic

#### ARG 209 - 217
+ Air Conditioning Panel
+ 209: Cockpit
+ 210: Auto/Man
+ 211: Auto temp Control
+ 212: Aircond Master
+ 213: Defog Flow
+ 214: CMPTR EMER Cool
+ 215: Engine deice
+ 216: windshield deice
+ 217: pitot heat

#### ARG 218 - 220
+ Wing Folding
+ 218: push button
+ 219: lift handle
+ 220: Pin lock switch

#### ARG 221 - 224
+ Center ICS Panel
+ 221: INPTH Volume
+ 222: ICS Ampl select
+ 223: mic sems
+ 224: hot/cold

#### ARG 225 - 233
+ RADIO mix Panel
+ 225: trans 
+ 226: UHF
+ 227: AUX
+ 228: TAC
+ 229: Volume
+ 230: ALQ FWD
+ 231: ALQ AFT
+ 232: APR-25
+ 233: APR-27

#### ARG 234 - 237
+ End panel of center panel
+ 234: CABIN Dump
+ 235: UHF ANT SEL
+ 236: TACAN ANT SEL
+ 237: CNI Master

----------

## Display Instruments
#### ARG 301
+ angle of attack indicator
+ -1:off; 0 = 0; 1 = 30
#### ARG 302
+ radar altitude
+ -1 = off; 0 = 0ft; 0.5 = 500ft;
+ 0.65 = 1000ft; 0.881 = 3000ft; 1 = 5000ft

#### ARG 303 - 308
+ engine indicator
+ 303-304: RPM
+ 305-306: EGT
+ 307-308: FF (fuel flow)

#### ARG 309 - 312
+ engine power trim
+ 309-310: Power trim
+ 311-312: O.P.

#### ARG 313 - 316
+ 313: slat
+ 314: STAB
+ 315: flap
+ 316: speed brake

#### ARG 318 - 320
+ 318: Nose; 319: Left; 320: Right

#### ARG 321 - 360
+ 321: air speed ind; 322: mach ind
+ 323: G meter
+ 324: Gyro roll, 325 Gyro pitch
+ 326: clock: hour; 327: clock: min; 328: clock: second;
+ 329: oxygen gauge;
+ 330: altitude needle; 331: altitude x100ft; 332: altitude x1000ft; 333:altitude x10000ft;
+ Baro dis(2992, mmHg): 334: x1000; 335: x100; 336: x10; 337: x1;
+ 338: baro altimeter OFF
+ 339: climb rate
+ 340: slide
+ 341: HSI compass; 342: Course; 343: Course_Tofrom; 344: Heading; 345: TACAN; 346: ADF;
+ 347 - 350: TACAN distance display; 351 - 353: Course Degree
+ 354: Fuel Quantity Inner; 355: Fuel Quantity Selection; 356 - 360: Fuel QUnantity All Display


## Bomber Panel Starts from ARG 500
#### ARG 501 - 529
+ Armater Panel TOP
+ 501 - 505: Selection of station Ind Lights
+ 506 - 510: Select Buttons
+ 511 - 515: Station Load Display
+ 516 - 520: Station Selection Switch
+ 521: Master Arm Switch
+ 522: L out Selection Light
+ 523: L out Select Button
+ 524: L out Load Display
+ 525: L out Select Switch
+ 526: R out Selection Light
+ 527: R out Select Button
+ 528: R out Load Display
+ 529: R out Select Switch
+ 562: Reselect Light
+ 563: Complete Light

#### ARG 531 - 561
+ 531 - 538: Release Mode
+ 539 - 546: Attack Mode
+ 547: mech arm
+ 548: rocket fire mode (single/ ripple)
+ 549: Guns mode select
+ 550 - 552: Interval Select
+ 553 - 555: Qunantity Select
+ 556 - 557: Time Select
+ 558: missile control
+ 559: missile cooling
+ 560: missile tone
+ 561: missile pwr

#### ARG 564 - 566
+ 564: HVDC light
+ 565: HVDC test button
+ 566: HVDC mode Roller

#### ARG 567 - 575
+ Nuclear Panel
+ 567: Station 2 light
+ 568: Station 3 light
+ 569: Station 4 light
+ 570: Arm Light
+ 571: Safe Light
+ 572: OFF Button
+ 573: Safe Button
+ 574: GND Button
+ 575: AIR Button