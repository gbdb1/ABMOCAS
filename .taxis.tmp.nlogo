
@#$#@#$#@
GRAPHICS-WINDOW
270
10
1188
929
-1
-1
14.0
1
10
1
1
1
0
0
0
1
-32
32
-32
32
1
1
1
ticks
30.0

BUTTON
15
538
99
571
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
0
162
260
195
num-taxicab
num-taxicab
1
5000
100.0
1
1
NIL
HORIZONTAL

SLIDER
0
68
260
101
length-of-green-light
length-of-green-light
1
30
30.0
1
1
ticks
HORIZONTAL

BUTTON
146
539
230
573
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
175
590
259
624
go-once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

MONITOR
61
12
171
57
Time of the Day
current-phase
17
1
11

SLIDER
0
114
260
147
length-of-time-period
length-of-time-period
1
5000
338.0
1
1
NIL
HORIZONTAL

INPUTBOX
20
245
125
305
wait-time-mean
100.0
1
0
Number

INPUTBOX
130
245
248
305
wait-time-sd
10.0
1
0
Number

SLIDER
-1
392
259
425
first-passenger-cost
first-passenger-cost
0
10
0.59
0.01
1
$
HORIZONTAL

SLIDER
-1
426
259
459
each-additional-passenger-cost
each-additional-passenger-cost
0
5
0.28
0.01
1
$
HORIZONTAL

SLIDER
-1
459
259
492
each-grid-cost
each-grid-cost
0
10
0.92
0.01
1
$
HORIZONTAL

SLIDER
-1
492
259
525
each-tick-cost
each-tick-cost
0.01
5
0.48
0.01
1
$
HORIZONTAL

TEXTBOX
9
316
257
388
Fare Calculation:\n- First passenger: $1\n- Each additional passenger: $0.5\n- Each additional grid: $1\n- Every tick of time elapsed: $0.5
11
0.0
1

TEXTBOX
11
209
267
251
Passenger Patience:\nNormal Distribution Parameters
11
0.0
1

PLOT
1230
10
1795
263
Taxicabs Travelling Distance
NIL
Miles
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Total Miles" 1.0 0 -16777216 true "" "plot sum [num-total-miles] of taxicabs"
"Business Miles" 1.0 0 -13840069 true "" "plot sum [num-business-miles] of taxicabs"
"Dead Miles" 1.0 0 -2674135 true "" "plot sum [num-dead-miles] of taxicabs"

PLOT
1229
260
1409
410
Trip Income Distribution
NIL
NIL
0.0
300.0
0.0
10.0
true
false
"set-histogram-num-bars 30" ""
PENS
"Trip Income" 1.0 1 -4079321 true "" "histogram reduce sentence [trip-income-lst] of taxicabs"

PLOT
1405
260
1597
410
Trip Distance Distribution
NIL
NIL
0.0
300.0
0.0
10.0
true
false
"set-histogram-num-bars 30" ""
PENS
"default" 1.0 1 -5825686 true "" "histogram reduce sentence [trip-distance-lst] of taxicabs"

PLOT
1595
260
1795
410
Trip Duration Distribution
NIL
NIL
0.0
300.0
0.0
10.0
true
false
"set-histogram-num-bars 30" ""
PENS
"default" 1.0 1 -14835848 true "" "histogram reduce sentence [trip-duration-lst] of taxicabs"

CHOOSER
0
595
166
640
type-of-passenger-spawns
type-of-passenger-spawns
"workday" "weekend" "holiday" "super-bowl" "no-spawns"
0

SLIDER
25
650
198
683
gas-cost-per-patch
gas-cost-per-patch
0
10
0.2
0.01
1
NIL
HORIZONTAL

PLOT
1230
410
1795
730
total profit
ticks
dollars
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot sum [real-total-income] of taxicabs"

TEXTBOX
26
716
241
854
Improved Taxi Cab by WUR
16
0.0
1

@#$#@#$#@
## WHAT IS IT?

The model mimics taxi cab ridership in an urban area. Users can control ridership demand, fleet size, traffic rules, and fare calculation. The model aims to reveal insights into taxi cab profitability based on trip characteristics and demand dynamics.

## Improvements by WUR students
1. Vision of taxi
2. Profit calculation
3. Easy scenario switcher
### Vision of Taxi
A vision combined with a circle and cone.
Defects:
1. the vision could see through buildings
2. It is not identical to real life vision.
### Profit Calculation
total cost = dead miles * gas cost per mile
total profit = total income – total cost
Defects:
1. standing-still cars consume gasoline, in fact.
## HOW IT WORKS

The urban area is portrayed as a grid system, which is formed by two-lane roads and intersections. The metropolitan area consists of three regions: (1) Central Business District (in orange), (2) Commercial Zone (in blue), and (3) Residential Zone (in grey). The three regions can form nine origin-destination (OD) pairs, with six pairs of inter-regional flows and three pairs of intra-regional flows.

Since taxi demands for each type of flow can be dramatically different based on the time of a day, users can control the amount of flow from regions to regions through the interface.

Potential passenger(s) show up on roads controlled by users. When a vacant taxicab happens to pass by, it stops and pickups the passenger(s). The passenger(s) inform the taxicab of the destination coordinate, and the taxi turns light-purple and starts the trip. The taxi will travel from the pickup coordinate to the light-purple colored drop-off coordinate by the shortest Manhattan distance and complete the trip when it arrives at the destination coordinate.

After finishing a trip, the taxi becomes vacant and searches for the next passenger(s) by traveling randomly on roads.

## HOW TO USE IT

### Taxicab Demand
* Spatial Flow and Time Interval:
- _Time Interval_: The flow of residents in an urban area between regions can be quite different depending on the time of day. To indicate the differences in the spatial flow of taxi trips between regions throughout the day, a clock is created to keep track of the time in the world. Five distinct time intervals are implemented (1) AM Peak, (2) Midday, (3) PM Peak, (4) Evening, (5) Early Morning. A reporter shows the current time interval in the interface, and the length of each time interval can be controlled by a slider called LENGTH-OF-TIME-PERIOD.
- _Spatial Flow_: Demand for taxicabs in city districts can be variable, and different amounts of flows can be manipulated by users through the spatial flow sliders, which control the probability (or proportion) of trips that are going from an origin to a destination during a specific time interval. For such purposes, each time interval's marginal probabilities are shown by a reporter at the bottom of each slider column to remind the users that the marginal probability should sum to 1.

### Traffic Rules
* Traffic Lights: the length of red/green lights can be controlled by a slider in the interface called LENGTH-OF-GREEN-LIGHT.

### Passengers
* Passenger waiting time is modeled by a normal distribution. The parameters of this normal distribution can be input by users in the interface through WAIT-TIME-MEAN and WAIT-TIME-SD.

### Taxicabs
* Fleet size: taxicab fleet size can be controlled by a slider NUM-TAXICABS.

* Trip Fare: Trip fare is calculated based on Chicago Yellow Taxicab. Trip fare is mainly calculated by three different variables: (1) the number of passengers on-board, (2) the number of miles traveled, (3) the trip duration. These cost variables can be determined by users in the interface using FIRST-PASSENGER-COST, EACH-ADDITIONAL-PASSENGER-COST, EACH-GRID-COST, and EACH-TICK-COST.

## THINGS TO NOTICE

As the model runs, the trade-off between business miles and dead miles can be contrasting. The distributions of trip income, distance, and duration should be correlated, and the overall shapes of the distribution are susceptible to the changes in traffic rules and interval lengths.

## THINGS TO TRY

For a clear visualization of the pickup and dropoff process, it is suggested to start with one taxicab to see how a taxicab behaves before generating multiple taxicabs.

## EXTENDING THE MODEL

There are many ways to extend this model. Interesting avenues would be to use real-world data with the GIS extension, more complex searching strategies, such as using AI tools, and including rideshare systems such as Uber or Lyft in the model, to better understand the relation between taxicabs and the rideshare systems.

Some other meaningful extension specific to taxicabs is to figure out how to reduce the number of dead miles -- miles traveled by taxicabs with no passengers on-board. Dead miles are costly to drivers because drivers need to internalize vehicle depreciation and gasoline price while searching for passengers. Figuring out more intelligent searching strategies such as locating the next passenger immediately after the last dropoff will be meaningful to pursue.

## NETLOGO FEATURES

Each road in the model is formed by two lanes, with each lane allowing taxicabs to travel in one direction. When delivering passengers, taxicabs will make U-turns to put themselves in the right direction to start the delivery following the shortest Manhattan distance. Some workarounds can be done to avoid making the u-turns.

## RELATED MODELS

- "Traffic Basic": a simple model of the movement of cars on a highway.
- "Traffic Basic Utility": a version of "Traffic Basic" including a utility function for the cars.
- "Traffic 2 Lanes": a more sophisticated two-lane version of the "Traffic Basic" model.

## HOW TO CITE

If you mention this model or the NetLogo software in a publication, we ask that you include the citations below.

For the model itself:

* Dongping, Z. and Wilensky, U. (2019).  NetLogo Taxi Cabs model.  http://ccl.northwestern.edu/netlogo/models/TaxiCabs.  Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

Please cite the NetLogo software as:

* Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

This model was developed as part of the Spring 2019 Multi-agent Modeling course offered by Dr. Uri Wilensky at Northwestern University. For more info, visit http://ccl.northwestern.edu/courses/mam/. Special thanks to Teaching Assistants Sugat Dabholkar, Can Gurkan, and Connor Bain.

## COPYRIGHT AND LICENSE

Copyright 2019 Uri Wilensky.

![CC BY-NC-SA 3.0](http://ccl.northwestern.edu/images/creativecommons/byncsa.png)

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License.  To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

Commercial licenses are also available. To inquire about commercial licenses, please contact Uri Wilensky at uri@northwestern.edu.

<!-- 2019 MAM2019 Cite: Dongping, Z. -->
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
