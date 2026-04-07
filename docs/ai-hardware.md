# AI Hardware

The massive parallel computations required in this new era of AI are a poor fit for the traditional CPU's of yesteryear. This is driving a transformation in computer architecture, toward making GPU's integral and high-bandwidth memory common. This architecture was formerly featured only in advanced gaming workstations, military simulation servers, or CGI media production labs.

## Apple

Local inference on Apple hardware is defined by Apple Silicon (M-series chips) and its Unified Memory Architecture (UMA). Unlike traditional PCs where the GPU has separate VRAM, UMA allows the CPU and GPU to share a single pool of high-speed memory. This is a major advantage for AI, as it eliminates the VRAM bottleneck; a MacBook Pro with 64GB of RAM can dedicate nearly all of it to a model, enabling users to run very large models (70B+ parameters) locally. The software foundation is the [Metal](https://developer.apple.com/metal/) framework for low-level GPU programming and Core ML for deploying optimized models. The ecosystem is rapidly maturing with tools like Apple's own MLX framework and community projects like [llama.cpp](https://llama-cpp.com/) that are highly optimized for the platform.

- [Mac Mini](https://www.apple.com/mac-mini/)
- [Mac Studio](https://www.apple.com/mac-studio/)

## AMD

The ecosystem for local inference on AMD hardware is built around [ROCm](https://rocm.docs.amd.com/) (Radeon Open Compute platform), an open-source suite of drivers, compilers, and libraries for GPU computing. ROCm provides tools like the [HIP](https://rocm.docs.amd.com/en/latest/understand/hip_faq.html) (Heterogeneous-compute Interface for Portability) layer, which helps developers port CUDA applications to run on AMD GPUs. For monitoring, the `rocm-smi` command-line tool functions similarly to `nvidia-smi`, providing real-time data on GPU usage and temperature. While historically focused on Linux and the data center, ROCm support for consumer cards and frameworks like PyTorch has improved significantly, making it a viable platform for AI enthusiasts.

- [Radeon RX 7000](https://www.amd.com/en/products/graphics/desktops/radeon/7000-series.html) series, based on the RDNA 3 architecture, presents a strong value proposition for local AI. The flagship Radeon RX 7900 XTX is particularly noteworthy for its 24GB of GDDR6 VRAM, which rivals high-end NVIDIA cards but often at a more accessible price point. This large memory buffer is ideal for running 30B+ parameter models with quantization, or even 70B models in some cases. For developers and researchers on Linux, the combination of high VRAM and improving ROCm support makes these cards a compelling alternative to NVIDIA for running large language models without breaking the bank.

## Intel

For local inference on Intel hardware, the ecosystem revolves around the [OpenVINO Toolkit](https://www.intel.com/content/www/us/en/developer/tools/openvino-toolkit/overview.html). OpenVINO (Open Visual Inference & Neural Network Optimization) is a suite of tools that optimizes deep learning models for high performance on Intel CPUs, integrated graphics (iGPUs), and discrete GPUs like Intel Arc. It allows developers to convert models from popular frameworks (like [TensorFlow](https://www.tensorflow.org/), [PyTorch](https://pytorch.org/get-started/locally/), & [ONNX](https://onnx.ai/onnx/intro/)) and deploy them efficiently. For monitoring, the `intel_gpu_top` command (part of the [intel-gpu-tools](https://github.com/tiagovignatti/intel-gpu-tools/blob/master/README) package on Linux) provides a `top`-like interface to see real-time usage of the GPU, which is invaluable for debugging performance.

- Intel Arc series GPUs (e.g., [A750](https://www.intel.com/content/www/us/en/products/sku/227954/intel-arc-a750-graphics/specifications.html), [A770](https://www.intel.com/content/www/us/en/products/sku/229151/intel-arc-a770-graphics-16gb/specifications.html)) have emerged as an affordable and powerful option for local AI inference. The A770, with its 16GB VRAM option, offers a compelling price-to-memory ratio, allowing enthusiasts to run larger models (13B to 30B parameter range with quantization) that are often out of reach for similarly priced competitors. While driver support was initially a challenge, it has matured significantly. On Linux, support is integrated into the Mesa drivers, and frameworks like PyTorch can leverage Arc GPUs via the Intel Extension for PyTorch (IPEX). On Windows, they are a first-class citizen for DirectML-based applications, making them a viable alternative for AI hobbyists.

## Nvidia

- [DGX Spark](https://www.nvidia.com/en-us/products/workstations/dgx-spark/) uses the GB10 Grace Blackwell superchip to deliver a petaFLOP of FP4 AI performance in a power-efficient, compact form factor. Has a preinstalled Ubuntu Linux + Nvidia AI software stack and 128 GB of memory.
- [Jetson Developer Kits](https://developer.nvidia.com/embedded/jetson-developer-kits) enable professionals, students, and enthusiasts to develop & test software for Nvidia-based products. Each kit includes a Jetson module on a reference carrier board with standard interfaces for flexible development and prototyping.

### Nvidia Drivers, Tools & Libraries

The NVIDIA System Management Interface [`nvidia-smi`](https://docs.nvidia.com/deploy/nvidia-smi/ "Nvidia man page") command line tool allows to manage, monitor and get information about Nvidia GPU devices installed in the system. It is installed along with the [CUDA toolkit](https://developer.nvidia.com/cuda-downloads) and based on top of the NVIDIA Management Library (NVML); it ships with [NVIDIA GPU display drivers on Linux](https://ubuntu.com/server/docs/how-to/graphics/install-nvidia-drivers/ "Ubuntu").
It allows owners to query GPU device state and with the appropriate privileges, permits administrators to modify GPU device state.

- [2026/1: Guide to nvidia-smi on Ubuntu](https://linuxvox.com/blog/nvidia-smi-ubuntu/ "Linux Vox")
- [2025/3: Displaying Full GPU Details With nvidia-smi (by Ismail Ajagbe)](https://www.baeldung.com/linux/nvidia-smi-full-gpu-details "Baeldung Linux")
- [SMI Queries for Troubleshooting](https://nvidia.custhelp.com/app/answers/detail/a_id/3751/~/useful-nvidia-smi-queries)
- [How to Use Nvidia-smi Command on Windows and Ubuntu Linux](https://www.gpu-mart.com/blog/monitor-gpu-utilization-with-nvidia-smi "GPU Mart")
- [2025/11 Omer Sen: NVIDIA-SMI Comprehensive Cheat Sheet](https://gist.github.com/omerfsen/8ecb620675525ac724a92bdf5a31a4b3)

### GeForce RTX 20x0

The RTX 20-series cards, based on the Turing architecture, are a good entry point for serious local AI experimentation, especially models with 8GB of VRAM (like the RTX 2070/2080). This amount of memory is a sweet spot, comfortably fitting popular `7B` and `8B` parameter models at full precision or with light quantization. With 4-bit quantization (e.g., using ollama), an 8GB card can even run some 13B models. The Turing architecture's Tensor Cores provide a significant speedup for mixed-precision inference, making these cards much faster than older generations. For a smooth experience, using tools like [ollama](./ollama.md) or [text-generation-webui](https://github.com/oobabooga/text-generation-webui/tree/main?tab=readme-ov-file#text-generation-web-ui) with quantized model formats (<abbr title="GPT-Generated Unified Format">GGUF</abbr>, <abbr title="Activation-aware Weight Quantization">AWQ</abbr>) is highly recommended to balance performance and memory usage.

### T1000

[T1000](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/productspage/quadro/quadro-desktop/proviz-print-nvidia-T1000-datasheet-us-nvidia-1670054-r4-web.pdf)
is a [Quadro](https://www.nvidia.com/en-in/drivers/quadro-desktop-gpu-specs/), Turing card with 4gb GDDR6 memory, 128-bit interface, 160 GB/s bandwidth, 2.50 TFLOPS.

- Avoid 7B/8B models: While you can run them (like Llama 3.1 8B), they will exceed your `4`GB VRAM. Ollama will "spill" the remaining layers to your system RAM/CPU, and your speed will drop from ~50+ tokens/sec to about 3–5 tokens/sec. Stick to models labeled "4B" or lower for that smooth, local-only feel.
- Monitor your VRAM: Open a terminal tab and run `nvidia-smi -l 1` to see how much of that VRAM you're using in real-time.
- Update the stuff: Ensure your drivers are up to date to take advantage of speed optimizations that Ollama uses by default on Turing cards.
- **NVFP4** Support: Newer versions of Ollama support NVFP4, a quantization format specifically for Nvidia cards that can reduce memory usage by nearly 50% with minimal quality loss. This might let you squeeze a 7B model into your 4GB VRAM comfortably.
