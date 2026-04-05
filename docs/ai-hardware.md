# AI Hardware

## Nvidia drivers

The NVIDIA System Management Interface [`nvidia-smi`](https://docs.nvidia.com/deploy/nvidia-smi/ "Nvidia man page") command line tool allows to manage, monitor and get information about Nvidia GPU devices installed in the system. It is installed along with the [CUDA toolkit](https://developer.nvidia.com/cuda-downloads) and based on top of the NVIDIA Management Library (NVML); it ships with [NVIDIA GPU display drivers on Linux](https://ubuntu.com/server/docs/how-to/graphics/install-nvidia-drivers/ "Ubuntu").
It allows owners to query GPU device state and with the appropriate privileges, permits administrators to modify GPU device state. While targeted at the Tesla, GRID, Quadro, and Titan X products, limited support is also available on other NVIDIA GPUs. Nvidia-smi can report query information as `XML` or human readable plain text.

- [2026/1: Guide to nvidia-smi on Ubuntu](https://linuxvox.com/blog/nvidia-smi-ubuntu/ "Linux Vox")
- [2025/3: Displaying Full GPU Details With nvidia-smi (by Ismail Ajagbe)](https://www.baeldung.com/linux/nvidia-smi-full-gpu-details "Baeldung Linux")
- [SMI Queries for Troubleshooting](https://nvidia.custhelp.com/app/answers/detail/a_id/3751/~/useful-nvidia-smi-queries)
- [How to Use Nvidia-smi Command on Windows and Ubuntu Linux](https://www.gpu-mart.com/blog/monitor-gpu-utilization-with-nvidia-smi "GPU Mart")
- [2025/11 Omer Sen: NVIDIA-SMI Comprehensive Cheat Sheet](https://gist.github.com/omerfsen/8ecb620675525ac724a92bdf5a31a4b3)

### Quadro T1000

[T1000](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/productspage/quadro/quadro-desktop/proviz-print-nvidia-T1000-datasheet-us-nvidia-1670054-r4-web.pdf)
was a graphics card with 4gb GDDR6 memory, 128-bit interface, 160 GB/s bandwidth, 2.50 TFLOPS.

- Avoid 7B/8B models: While you can run them (like Llama 3.1 8B), they will exceed your `4`GB VRAM. Ollama will "spill" the remaining layers to your system RAM/CPU, and your speed will drop from ~50+ tokens/sec to about 3–5 tokens/sec. Stick to models labeled "4B" or lower for that smooth, local-only feel.
- Monitor your VRAM: Open a terminal tab and run `nvidia-smi -l 1` to see how much of that VRAM you're using in real-time.
- Update the stuff: Ensure your drivers are up to date to take advantage of speed optimizations that Ollama uses by default on Turing cards.
- **NVFP4** Support: Newer versions of Ollama support NVFP4, a quantization format specifically for Nvidia cards that can reduce memory usage by nearly 50% with minimal quality loss. This might let you squeeze a 7B model into your 4GB VRAM comfortably.
