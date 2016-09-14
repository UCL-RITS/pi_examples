

local num_steps
if arg[1] == nil then
	num_steps = 100000000
else
	num_steps = arg[1]
end

local i=0
local sum = 0.0
local step = 1.0 / num_steps

print("Calculating pi using:\n  "..num_steps.." slices\n  1 process")

-- This timer only has a clock resolution of 10 milliseconds apparently but it's
--  the best we can do with ordinary lua.
local start_time = os.clock()

for i = 0, num_steps - 1 do
    x = (i + 0.5) * step
    sum = sum + (4.0 / (1.0 + x*x))
end

local pi = sum * step

local end_time = os.clock()

local duration = end_time - start_time

print("Obtained value for PI: "..pi.."\n"..
      "Time taken: "..duration.." seconds")

