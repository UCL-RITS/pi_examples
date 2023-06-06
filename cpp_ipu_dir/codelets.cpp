#include <poplar/Vertex.hpp>

using namespace poplar;

class VertexPi : public Vertex {
public:
    Input<unsigned> id;
    Input<unsigned> n;
    Input<float> slice;
    Output<Vector<float>> out;
    Output<Vector<unsigned>> cycles;

    bool compute() {
        float sum = 0;
        unsigned start = __builtin_ipu_get_scount_l();
        for (unsigned j=id * n; j <= (id + 1) * n - 1; j++) {
            float x = (j - 0.5f) * slice;
            sum += 4 / (1 + x * x);
        }
        unsigned end = __builtin_ipu_get_scount_l();
        out[0] = sum;
        cycles[0] = end - start;
        return true;
    }
};
