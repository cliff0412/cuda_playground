# run
```
nvcc -o device_query src/device_query.cu
./device_query

nvcc -arch=compute_89 -code=sm_89 -o copy_test src/copy_test.cu
```