# AI Hardware

The massive parallel computations required in this new era of AI are a poor fit for the traditional CPU's of yesteryear. This is driving a transformation in computer architecture, toward making GPU's integral and high-bandwidth memory common. This architecture was formerly featured only in advanced gaming workstations, military simulation stations, or CGI media production labs.

_Tools like [llmfit](./llmfit.md) can help you identify the [LLM's](./ai-models.md) that will perform best on specific hardware you already own._

## Apple

Local inference on Apple hardware is defined by Apple Silicon ([M-series chips](https://www.apple.com/newsroom/2025/10/apple-unleashes-m5-the-next-big-leap-in-ai-performance-for-apple-silicon/)) and its Unified Memory Architecture (UMA). Unlike traditional PCs where the GPU has separate VRAM, UMA allows the CPU and GPU to share a single pool of high-speed memory. This is a major advantage for AI, as it eliminates the VRAM bottleneck; a MacBook Pro with 64GB of RAM can dedicate nearly all of it to a model, enabling users to run very large [models](./ai-models.md) (70B+ parameters) locally. The software foundation is the [Metal](https://developer.apple.com/metal/) framework for low-level GPU programming and [Core ML](https://developer.apple.com/machine-learning/core-ml/) for deploying optimized [models](./ai-models.md). The ecosystem is rapidly maturing with tools like Apple's own [MLX framework](https://mlx-framework.org/) and community projects like [llama.cpp](https://llama-cpp.com/) that are highly optimized for the platform.

- [Mac Mini](https://www.apple.com/mac-mini/)
- [Mac Studio](https://www.apple.com/mac-studio/)

## AMD

The ecosystem for local inference on AMD hardware is built around [ROCm](https://rocm.docs.amd.com/) (Radeon Open Compute platform), an open-source suite of drivers, compilers, and libraries for GPU computing. ROCm provides tools like the [HIP](https://rocm.docs.amd.com/en/latest/understand/hip_faq.html) (Heterogeneous-compute Interface for Portability) layer, which helps developers port CUDA applications to run on AMD GPUs. For monitoring, the `rocm-smi` command-line tool functions similarly to `nvidia-smi`, providing real-time data on GPU usage and temperature. While historically focused on Linux and the data center, ROCm support for consumer cards and frameworks like PyTorch has improved significantly, making it a viable platform for AI enthusiasts.

- [Ryzen AI Max processors](https://www.amd.com/en/products/processors/consumer/ryzen-ai.html) integrate a dedicated Neural Processing Unit (NPU) alongside the CPU and RDNA 3-based integrated graphics, creating a powerful hybrid AI architecture for modern laptops. The NPU is optimized for sustained, low-power AI workloads, such as real-time video effects, voice processing, and local AI assistants, significantly extending battery life. For more demanding AI inference tasks, like running larger language [models](./ai-models.md) or complex generative AI, applications can leverage the more powerful integrated GPU. This multi-engine approach, supported by AMD's software ecosystem (including ROCm and NPU-specific SDKs), allows for intelligent workload distribution, making Ryzen AI Max a versatile and efficient platform for on-device AI.
- [Radeon RX 7000](https://www.amd.com/en/products/graphics/desktops/radeon/7000-series.html) series, based on the RDNA 3 architecture, presents a strong value proposition for local AI. The flagship Radeon RX 7900 XTX is particularly noteworthy for its 24GB of GDDR6 VRAM, which rivals high-end NVIDIA cards but often at a more accessible price point. This large memory buffer is ideal for running 30B+ parameter [models](./ai-models.md) with quantization, or even 70B [models](./ai-models.md) in some cases. For developers and researchers on Linux, the combination of high VRAM and improving ROCm support makes these cards a compelling alternative to NVIDIA for running large language [models](./ai-models.md) without breaking the bank.

## Intel

For local inference on Intel hardware, the ecosystem revolves around the [OpenVINO Toolkit](https://www.intel.com/content/www/us/en/developer/tools/openvino-toolkit/overview.html). OpenVINO (Open Visual Inference & Neural Network Optimization) is a suite of tools that optimizes deep learning [models](./ai-models.md) for high performance on Intel CPUs, integrated graphics (iGPUs), and discrete GPUs like Intel Arc. It allows developers to convert [models](./ai-models.md) from popular frameworks (like [TensorFlow](https://www.tensorflow.org/), [PyTorch](https://pytorch.org/get-started/locally/), & [ONNX](https://onnx.ai/onnx/intro/)) and deploy them efficiently. For monitoring, the `intel_gpu_top` command (part of the [intel-gpu-tools](https://github.com/tiagovignatti/intel-gpu-tools/blob/master/README) package on Linux) provides a `top`-like interface to see real-time usage of the GPU, which is invaluable for debugging performance.

- Intel Arc series GPUs (e.g., [A750](https://www.intel.com/content/www/us/en/products/sku/227954/intel-arc-a750-graphics/specifications.html), [A770](https://www.intel.com/content/www/us/en/products/sku/229151/intel-arc-a770-graphics-16gb/specifications.html)) have emerged as an affordable and powerful option for local AI inference. The A770, with its 16GB VRAM option, offers a compelling price-to-memory ratio, allowing enthusiasts to run larger [models](./ai-models.md) (13B to 30B parameter range with quantization) that are often out of reach for similarly priced competitors. While driver support was initially a challenge, it has matured significantly. On Linux, support is integrated into the Mesa drivers, and frameworks like PyTorch can leverage Arc GPUs via the Intel Extension for PyTorch (IPEX). On Windows, they are a first-class citizen for DirectML-based applications, making them a viable alternative for AI hobbyists.
 - Intel's [Core Ultra processors](https://www.intel.com/content/www/us/en/ark/products/series/241071/intel-core-ultra-processors-series-2.html) bring a hybrid AI architecture to modern laptops, integrating three distinct compute engines on a single chip: the CPU, an integrated Arc GPU, and a new Neural Processing Unit (NPU). This design relies on a unified memory architecture, allowing the CPU, GPU, and NPU to efficiently share system RAM for AI tasks. The NPU is designed for low-power, sustained AI workloads—like real-time background blur or noise cancellation—enabling "always-on" features without draining the battery. For more demanding tasks, such as running local language models or generative AI, applications can leverage the more powerful integrated Arc GPU. The OpenVINO toolkit orchestrates this by allowing developers to intelligently offload tasks to the most appropriate engine, making these laptops versatile platforms for both efficient, everyday AI assistance and on-device inference.

## Nvidia

NVIDIA's dominance in AI is built on successive GPU architectures, each bringing significant performance gains.

In 2016, the [Pascal](https://developer.nvidia.com/blog/inside-pascal/) architecture (GeForce 10-series) was the workhorse of the early deep learning boom, but it lacked specialized hardware. The data-center-focused [Volta](https://www.nvidia.com/en-us/data-center/volta-gpu-architecture/) architecture first introduced Tensor Cores, but it was the subsequent [Turing](https://developer.nvidia.com/blog/nvidia-turing-architecture-in-depth/) architecture (GeForce 20-series, Quadro RTX) in 2018 that brought them to the consumer market, making it a watershed moment. These cores dramatically accelerated mixed-precision matrix operations—a core component of AI inference and training.
In 2020, the [Ampere](https://developer.nvidia.com/blog/nvidia-ampere-architecture-in-depth/) architecture (GeForce 30-series) refined these cores and offered a massive leap in performance, making high-end AI development more accessible on consumer cards.

The data-center-exclusive [Hopper](https://www.nvidia.com/en-us/data-center/hopper-architecture/) architecture pioneered features like the Transformer Engine for enterprise AI. Its consumer-facing counterpart in 2022, [Ada Lovelace](https://en.wikipedia.org/wiki/Ada_Lovelace_(microarchitecture)) (GeForce 40-series, [whitepaper](https://images.nvidia.com/aem-dam/Solutions/geforce/ada/nvidia-ada-gpu-architecture.pdf)), and the 2024 [Grace Blackwell](https://en.wikipedia.org/wiki/Blackwell_(microarchitecture)) ([whitepaper](https://resources.nvidia.com/en-us-blackwell-architecture)) architecture continued this trend of performance gains. These later generations increased core counts, memory bandwidth, and added support for new data formats like FP8 to further boost efficiency for large model inference.

In 2026, [Vera Rubin](https://www.nvidia.com/en-us/data-center/vera-cpu/) shall continue this march in data centers with a 2x performance improvement.

### Nvidia Drivers, Tools & Libraries

The NVIDIA System Management Interface [`nvidia-smi`](https://docs.nvidia.com/deploy/nvidia-smi/ "Nvidia man page") command line tool allows to manage, monitor and get information about Nvidia GPU devices installed in the system. It is installed along with the [CUDA toolkit](https://developer.nvidia.com/cuda-downloads) and based on top of the NVIDIA Management Library (NVML); it ships with [NVIDIA GPU display drivers on Linux](https://ubuntu.com/server/docs/how-to/graphics/install-nvidia-drivers/ "Ubuntu").
It allows owners to query GPU device state and with the appropriate privileges, permits administrators to modify GPU device state.

- [2026/1: Guide to nvidia-smi on Ubuntu](https://linuxvox.com/blog/nvidia-smi-ubuntu/ "Linux Vox")
- [2025/3: Displaying Full GPU Details With nvidia-smi (by Ismail Ajagbe)](https://www.baeldung.com/linux/nvidia-smi-full-gpu-details "Baeldung Linux")
- [SMI Queries for Troubleshooting](https://nvidia.custhelp.com/app/answers/detail/a_id/3751/~/useful-nvidia-smi-queries)
- [How to Use Nvidia-smi Command on Windows and Ubuntu Linux](https://www.gpu-mart.com/blog/monitor-gpu-utilization-with-nvidia-smi "GPU Mart")
- [2025/11 Omer Sen: NVIDIA-SMI Comprehensive Cheat Sheet](https://gist.github.com/omerfsen/8ecb620675525ac724a92bdf5a31a4b3)

### Nvidia Developer Hardware

- [DGX Spark](https://www.nvidia.com/en-us/products/workstations/dgx-spark/) uses the GB10 _Grace Blackwell_ superchip to deliver a petaFLOP of FP4 AI performance in a power-efficient, compact form factor. Has a preinstalled Ubuntu Linux + Nvidia AI software stack and 128 GB of memory.
- [Jetson Developer Kits](https://developer.nvidia.com/embedded/jetson-developer-kits) enable professionals, students, and enthusiasts to develop & test software for Nvidia-based products. Each kit includes a Jetson module on a reference carrier board with standard interfaces for flexible development and prototyping.
  - _Grace Blackwell:_ Jetson AGX Thor
  - _Ampere:_ Jetson Orin Nano

### Nvidia T1000

[T1000](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/productspage/quadro/quadro-desktop/proviz-print-nvidia-T1000-datasheet-us-nvidia-1670054-r4-web.pdf)
is a [Quadro](https://www.nvidia.com/en-in/drivers/quadro-desktop-gpu-specs/), Turing card with 4gb GDDR6 memory, 128-bit interface, 160 GB/s bandwidth, 2.50 TFLOPS.

- Avoid 7B/8B [models](./ai-models.md): While you can run them (like Llama 3.1 8B), they will exceed your `4`GB VRAM. Ollama will "spill" the remaining layers to your system RAM/CPU, and your speed will drop from ~50+ tokens/sec to about 3–5 tokens/sec. Stick to [models](./ai-models.md) labeled "4B" or lower for that smooth, local-only feel.
- Monitor your VRAM: Open a terminal tab and run `nvidia-smi -l 1` to see how much of that VRAM you're using in real-time.
- Update the stuff: Ensure your drivers are up to date to take advantage of speed optimizations that Ollama uses by default on Turing cards.
- **NVFP4** Support: Newer versions of [Ollama](./ollama.md) support NVFP4, a quantization format specifically for Nvidia cards that can reduce memory usage by nearly 50% with minimal quality loss. This might let you squeeze a 7B model into your 4GB VRAM comfortably.

### Nvidia GeForce RTX 20-series

The RTX 20-series cards based on the Turing architecture, are a good entry point for serious local AI experimentation, especially [models](./ai-models.md) with 8GB of VRAM (like the RTX 2070/2080). This amount of memory is a sweet spot, comfortably fitting popular `7B` and `8B` parameter [models](./ai-models.md) at full precision or with light quantization. With 4-bit quantization (e.g., using ollama), an 8GB card can even run some 13B [models](./ai-models.md). The Turing architecture's Tensor Cores provide a significant speedup for mixed-precision inference, making these cards much faster than older generations. For a smooth experience, using tools like [ollama](./ollama.md) or [text-generation-webui](https://github.com/oobabooga/text-generation-webui/tree/main?tab=readme-ov-file#text-generation-web-ui) with quantized model formats (<abbr title="GPT-Generated Unified Format">GGUF</abbr>, <abbr title="Activation-aware Weight Quantization">AWQ</abbr>) is highly recommended to balance performance and memory usage.

## MediaTek

[Reportedly developed in collaboration with NVIDIA](https://www.forbes.com/sites/jonmarkman/2026/03/16/the-arm-invasion-nvidia-targets-200-billion-pc-market-with-n1x-chips/), [MediaTek](https://www.mediatek.com/)'s `N1` & `N1X` chips (expected in 2026) combine their ARM-based CPU expertise with NVIDIA’s powerful GPU & AI architecture.
These chips are expected to power thin-and-light laptops that outperform Qualcomm in graphics and gaming while maintaining an aggressive price point.
MediaTek is also positioning itself as a leader for "AI Chromebooks," leveraging a partnership with Google to challenge the standard PC definition with AI-centric, ARM-based hardware.

Based on recent developments in the partnership between MediaTek & NVIDIA, their upcoming chips are taking a "Linux-first, Windows-later" approach. This strategy is driven more by the immediate needs of the AI research community than a pure ideological push for open-source compatibility. While these chips are eventually aimed at the "Windows on ARM" consumer market, the initial high-end variants (like the `GB10` or `N1X`) are shipping first in _AI Workstations_ and _Personal AI Supercomputers_ (such as [Project DIGITS](https://www.thurrott.com/hardware/315540/mediatek-nvidia-confirm-partnership-on-arm-chips)). MediaTek is working with Linux to create a high-performance sandbox for AI users who want to bypass corporate cloud servers.

<!-- --

## Qualcomm

Qualcomm's Snapdragon processors, particularly the Snapdragon X Elite and X Plus series, are central to the new wave of AI-powered PCs. Their architecture is built around the powerful Hexagon NPU (Neural Processing Unit), designed for high-performance, low-power AI inference. This allows for sustained AI workloads—such as real-time translation, advanced camera features, and persistent on-device assistants—without a significant impact on battery life. The Qualcomm AI Engine orchestrates tasks across the NPU, CPU, and GPU, intelligently assigning workloads to the most efficient processor. This integrated approach, supported by the Qualcomm AI Stack, makes Snapdragon-powered devices, including the first wave of [Copilot+ PCs](https://www.qualcomm.com/laptops), ideal platforms for the emerging ecosystem of always-on, on-device AI applications.

Similar to Apple Silicon, Snapdragon X platforms use a Unified Memory Architecture (UMA), where the CPU, GPU, and NPU share the same pool of system RAM. This makes the price-to-RAM ratio the most critical factor for local LLM inference, as more memory directly allows for larger, more capable models to run efficiently on-device.

As of their launch, the initial wave of Copilot+ PCs from manufacturers like Samsung, Dell, Lenovo, and Acer ***do not have official Linux support.*** While the upstream Linux kernel is seeing active development for the Snapdragon X series, full, stable support for specific devices (including drivers for Wi-Fi, audio, and the NPU) will depend on ongoing community efforts and is not guaranteed. Therefore, for users prioritizing a Linux environment, it is advisable to wait for official announcements or confirmed community-vetted options.

<!-- -->

## Datacenter Hardware

While the hardware above focuses on local and workstation inference, the backbone of large-scale AI training and production inference runs on specialized hardware in cloud data centers.

### Hyperscalers

Tensor Processing Units ([TPU's](https://cloud.google.com/tpu/docs/intro-to-tpu)) are Google's custom-designed ASICs built specifically to accelerate machine learning workloads. Unlike general-purpose GPUs, TPUs are optimized for the massive matrix operations at the heart of neural networks. They are the power behind many of Google's own AI products (including Search and Gemini) and are available to developers through the Google Cloud Platform.

Amazon Web Services has developed its own custom chips to optimize performance and cost for AI workloads on its cloud platform.

-   [AWS Trainium](https://aws.amazon.com/ai/machine-learning/trainium/): These are second-generation machine learning accelerators built specifically for high-performance deep learning training.
-   [AWS Inferentia](https://aws.amazon.com/ai/machine-learning/inferentia/): These chips are designed to deliver high-performance inference at the lowest cost in the cloud.

Microsoft is also investing in custom silicon to power its AI ambitions. The [Azure Maia AI Accelerator](https://azure.microsoft.com/en-us/blog/azure-maia-for-the-era-of-ai-from-silicon-to-software-to-systems/) is designed to run large language model training and inference for OpenAI models and other workloads on Microsoft Azure.

### Specialized AI Accelerators

Beyond the major clouds, several companies focus exclusively on building novel hardware architectures for AI.

-   **Groq:** Known for its Language Processing Unit ([LPU](https://wow.groq.com/lpu-inference-engine/)) architecture, which is designed to deliver ultra-low latency for LLM inference, making it ideal for real-time conversational AI and agentic systems.
-   **Cerebras:** Builds systems around its Wafer-Scale Engine (WSE), a single, massive chip that contains trillions of transistors, designed to drastically reduce the time it takes to train large AI models.
-   **SambaNova Systems:** Offers a full-stack platform, from its Reconfigurable Dataflow Unit (RDU) chip to software, for training and deploying foundation models.

### RISC-V

The open-standard [RISC-V](https://riscv.org/) instruction set architecture (ISA) is fostering a new wave of innovation in custom AI hardware. It allows companies to design specialized, power-efficient processors and accelerators for AI without the licensing fees associated with proprietary architectures like ARM or x86. This is leading to a growing ecosystem of custom silicon tailored for specific AI tasks.
