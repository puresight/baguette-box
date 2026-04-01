# Fedora testing

These recipes were tested on Fedora Linux

- VARIANT="Silverblue"
- VARIANT_ID=bluefin-dx-nvidia-open
- CPE_NAME="cpe:/o:universal-blue:bluefin:43"

## Passed:

- install-gomplate
- install-viteplus
- install-rust
- install-uv
- install-tools-storage
- install-wasmer
- install-kubectl
- install-java
- install-kotlin
- install-scala
- install-go
- install-ruby
- install-rails
- display-environment
- display-versions

- code
- install-code
- install-code-extensions
- install-mise
- install-viteplus

## Failed:

- install-jekyll (requires g++)
- bootstrap
- check-apt
- configure-apt
- install-apt-packages
