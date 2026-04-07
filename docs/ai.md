# AI

The modern AI stack is a layered system, starting with the [hardware](./ai-hardware.md) that dictates performance.
On this foundation run the "brains" of the operation: the [AI models](./ai-models.md) themselves, ranging from small local LLM's to really big ones that run in cloud datacenters.
The process of running these models to process requests & generate responses is known as [inference](./ai-inference.md).
Inference can be performed in clouds, or on your own machine using an engine like [Ollama](./ollama.md), a tool for locally managing and executing open-weight models.
To simplify the complexity of using varying models running in assorted environments, an orchestration tool like [Stockyard](./stockyard.md) serves as your unified gateway. This lets you seamlessly switch between different models (whether self-hosted or running in a cloud) through a single endpoint on your computer.
