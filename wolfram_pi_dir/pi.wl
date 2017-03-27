#!/usr/bin/env wolframscript

If [Length[$ScriptCommandLine] > 1, n=FromDigits[$ScriptCommandLine[[2]]], n=5000000]

Print ["Calculating Pi with"]
Print ["  ", n, " slices"]

st = SessionTime[]

s = 0.0
step = 1.0/n

Do[s = s + (4.0/(1.0 + (((i-0.5)*step)*((i-0.5)*step)))) , {i,n} ]

mp = s / n

f = SessionTime[]
t = Round[f - st, 0.0001]

Print ["Obtained value of Pi: ", mp]
Print ["Time taken: ", t, " seconds"]
