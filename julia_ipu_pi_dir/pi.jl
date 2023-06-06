#!/usr/bin/env julia

using IPUToolkit.IPUCompiler, IPUToolkit.Poplar

ENV["POPLAR_RUNTIME_OPTIONS"] = """{"target.hostSyncTimeout":"20"}"""

device = Poplar.get_ipu_device()
target = Poplar.DeviceGetTarget(device)
graph = Poplar.Graph(target)

num_tiles = Int(Poplar.TargetGetNumTiles(target))
n::UInt32 = typemax(UInt32) ÷ num_tiles
num_steps::UInt32 = num_tiles * n
slice::Float32 = 1 / num_steps

tile_clock_frequency = Poplar.TargetGetTileClockFrequency(target)

ids = collect(UInt32.(0:(num_tiles - 1)))
sums = similar(ids, Float32)
cycles = similar(ids)

@eval function pi_kernel(i::T) where {T<:Integer}
    sum = 0f0
    for j in (i * $(n)):((i + one(T)) * $(n) - one(T))
        x = (j - 5f-1) * $(slice)
        sum += 4 / (1 + x ^ 2)
    end
    return sum
end

@codelet graph function Pi(in::VertexVector{UInt32, In},
                           out::VertexVector{Float32, Out},
                           cycles::VertexVector{UInt32, Out})
    cycles[begin] = @ipuelapsed(out[begin] = pi_kernel(in[begin]))
end

input = Poplar.GraphAddConstant(graph, ids)
output = similar(graph, input, Float32, "sums");
cs = similar(graph, input, UInt32, "cycles");

prog = Poplar.ProgramSequence()

add_vertex(graph, prog, 0:(num_tiles - 1), Pi, input, output, cs)

Poplar.GraphCreateHostRead(graph, "sums-read", output)
Poplar.GraphCreateHostRead(graph, "cycles-read", cs)

engine = Poplar.Engine(graph, prog)
Poplar.EngineLoadAndRun(engine, device)
Poplar.EngineReadTensor(engine, "sums-read", sums)
Poplar.EngineReadTensor(engine, "cycles-read", cycles)

Poplar.DeviceDetach(device)

pi = sum(sums) * slice
time = round(maximum(cycles) / tile_clock_frequency; sigdigits=4)

print("""
      Calculating PI using:
        $(num_steps) slices
        $(num_tiles) IPU tiles
      Obtained value of PI: $(pi)
      Time taken: $(time) seconds ($(maximum(cycles)) cycles at $(round(tile_clock_frequency / 1e9; sigdigits=3)) GHz)
      """)
