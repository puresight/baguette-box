## AI Hardware

### Nvidia T1000

> NVIDIA Quadro T1000
[pdf](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/productspage/quadro/quadro-desktop/proviz-print-nvidia-T1000-datasheet-us-nvidia-1670054-r4-web.pdf)
> is a graphics card with 4gb GDDR6 memory, 128-bit interface, 160 GB/s bandwidth, 2.50 TFLOPS.

- Avoid 7B/8B models: While you can run them (like Llama 3.1 8B), they will exceed your `4`GB VRAM. Ollama will "spill" the remaining layers to your system RAM/CPU, and your speed will drop from ~50+ tokens/sec to about 3–5 tokens/sec. Stick to models labeled "4B" or lower for that smooth, local-only feel.
- Monitor your VRAM: Open a terminal tab and run `nvidia-smi -l 1` to see how much of that VRAM you're using in real-time.
- Update the stuff: Ensure your drivers are up to date to take advantage of speed optimizations that Ollama uses by default on Turing cards.
- **NVFP4** Support: Newer versions of Ollama support NVFP4, a quantization format specifically for Nvidia cards that can reduce memory usage by nearly 50% with minimal quality loss. This might let you squeeze a 7B model into your 4GB VRAM comfortably.
