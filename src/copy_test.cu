#include <cuda.h>
#include <chrono>
#include <iostream>

#define N 2500

__global__ void vector_add(float *out, float *a, float *b, int n)
{
    for (int i = 0; i < n; i++)
    {
        out[i] = a[i] + b[i];
    }
}
int main()
{
    float *a, *b, *out;
    float *d_a, *d_b;

    a = (float *)malloc(sizeof(float) * N);

    // Allocate device memory for a
    cudaMalloc((void **)&d_a, sizeof(float) * N);

    auto startTime = std::chrono::high_resolution_clock::now();

    // Transfer data from host to device memory
    cudaMemcpy(d_a, a, sizeof(float) * N, cudaMemcpyHostToDevice);
    auto endTime = std::chrono::high_resolution_clock::now();

    // Calculate the elapsed time in nanoseconds
    auto elapsedTime = std::chrono::duration_cast<std::chrono::nanoseconds>(endTime - startTime).count();

    // Print the results
    std::cout << "Elapsed Time (nanoseconds): " << elapsedTime << std::endl;

    vector_add<<<1, 1>>>(out, d_a, b, N);

    // Cleanup after kernel execution
    cudaFree(d_a);
    free(a);
}