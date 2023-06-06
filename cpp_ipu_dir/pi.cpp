#include <cstdlib>
#include <vector>
#include <iostream>
#include <algorithm>
#include <numeric>

#include <poplar/DeviceManager.hpp>
#include <poplar/Device.hpp>
#include <poplar/Target.hpp>
#include <poplar/Graph.hpp>
#include <poplar/Engine.hpp>
#include <poplar/CodeletFileType.hpp>
#include <poplar/Program.hpp>
#include <poplar/Tensor.hpp>

using namespace poplar;
using namespace poplar::program;

int main(int argc, char **argv) {
    auto device_manager = DeviceManager();
    auto max_dev_id = device_manager.getNumDevices();
    Device device;
    for (unsigned id=0; id<max_dev_id; id++) {
        device = device_manager.getDevice(id);
        if (device.attach()) {
            std::cerr << "Using HW device ID: " << device.getId() << "\n";
            break;
        }
    }
    auto target = device.getTarget();
    Graph graph(target);

    auto num_tiles = target.getNumTiles();
    unsigned n = UINT32_MAX / num_tiles;
    unsigned num_steps = num_tiles * n;
    float slice = 1 / num_steps;

    auto tile_clock_frequency = target.getTileClockFrequency();

    unsigned ids[num_tiles];
    for (size_t i=0; i<num_tiles; i++) {
        ids[i] = i;
    }
    std::vector<float> sums(num_tiles);
    std::vector<unsigned> cycles(num_tiles);

    graph.addCodelets({"codelets.cpp"}, "-O3");

    Tensor input = graph.addConstant(UNSIGNED_INT, {num_tiles}, ids);
    Tensor output = graph.addVariable(FLOAT, {num_tiles}, "sums");
    Tensor cs = graph.addVariable(UNSIGNED_INT, {num_tiles}, "cycles");

    Sequence prog;

    auto compute_set = graph.addComputeSet("Pi");
    for (size_t i = 0; i < num_tiles; i++) {
        graph.setTileMapping(input[i], i);
        graph.setTileMapping(output[i], i);
        graph.setTileMapping(cs[i], i);
        auto vtx = graph.addVertex(compute_set, "VertexPi");
        graph.connect(vtx["id"], input[i]);
        graph.connect(vtx["n"], n);
        graph.connect(vtx["slice"], slice);
        graph.connect(vtx["out"], output.slice(i, i+1));
        graph.connect(vtx["cycles"], cs.slice(i, i+1));
        graph.setTileMapping(vtx, i);
    }
    prog.add(program::Execute(compute_set));

    graph.createHostRead("sums-read", output);
    graph.createHostRead("cycles-read", cs);

    Engine engine(graph, prog);
    engine.loadAndRun(device);

    engine.readTensor("sums-read", sums.data(), sums.data() + sums.size());
    engine.readTensor("cycles-read", cycles.data(), cycles.data() + cycles.size());

    device.detach();

    float pi = std::accumulate(sums.begin(), sums.end(), 0);
    pi *= slice;
    auto max_cycles = *std::max_element(cycles.begin(), cycles.end());
    double time = max_cycles / tile_clock_frequency;

    std::cout << "Calculating PI using:" << std::endl;
    std::cout << "  " << num_steps << " slices" << std::endl;
    std::cout << "  " << num_tiles << " IPU tiles" << std::endl;
    std::cout << "Obtained value of PI: " << pi << std::endl;
    std::cout << "Time taken: " << time << " seconds (" << max_cycles << " cycles at " << tile_clock_frequency / 1e9 << " GHz)" << std::endl;

    return 0;
}
