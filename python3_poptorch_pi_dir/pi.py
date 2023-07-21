#!/usr/bin/env python3

import torch
import poptorch
import time
import sys

# function to convert numbers into float32 tensors for IPU
def ipu_float(x):
    return torch.tensor(x, dtype=torch.float32, device="ipu")


# Define our "model"
class est_pi_net(torch.nn.Module):
    def forward(self, x, n):
        return ipu_float(4) / (ipu_float(1) + (((x - ipu_float(0.5))/n) * ((x - ipu_float(0.5))/n)))

# Main method
def estimate_pi(num_steps):
    print(f"Calculating PI with:\n  {num_steps} slices")

    start = time.time()
    model = est_pi_net()
    inference_model = poptorch.inferenceModel(model)

    x = torch.tensor(range(num_steps), dtype=torch.float32)
    n = torch.tensor([num_steps], dtype=torch.int32)


    p = sum(inference_model(x, n)).item()/num_steps
    stop = time.time()

    print(f"Obtained value of PI: {p}")
    print(f"Time taken: {stop - start} seconds")

if __name__ == "__main__":
    num_steps = 100000
    if len(sys.argv) > 1:
    	num_steps = int(sys.argv[1])
    estimate_pi(num_steps)