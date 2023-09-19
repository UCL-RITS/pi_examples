#!/usr/bin/env python3

import torch
import time
import sys

device_ = torch.device("cpu")

# function to convert numbers into float32 tensors for MDS
def device_float(x):
    return torch.tensor(x, dtype=torch.float32, device=device_)

def est_pi(x, n):
    return sum(device_float(4) / (device_float(1) + (((x - device_float(0.5))/n) * ((x - device_float(0.5))/n))))

# Main method
def estimate_pi(num_steps):
    print(f"Calculating PI with:\n  {num_steps} slices\n  {device_} torch device")

    start = time.time()

    x = torch.tensor(range(num_steps), dtype=torch.float32, device=device_)
    n = torch.tensor([num_steps], dtype=torch.int32, device=device_)

    p = est_pi(x, n)/num_steps
    stop = time.time()

    print(f"Obtained value of PI: {p}")
    print(f"Time taken: {stop - start} seconds")

if __name__ == "__main__":
    num_steps = 100000
    device="device"
    if len(sys.argv) > 1:
    	num_steps = int(sys.argv[1])
    if len(sys.argv) > 2:
        device_ = torch.device(sys.argv[2])

    estimate_pi(num_steps)
