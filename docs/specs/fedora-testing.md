# Fedora testing

These recipes were tested on Fedora Linux

- VARIANT="Silverblue"
- VARIANT_ID=bluefin-dx-nvidia-open
- CPE_NAME="cpe:/o:universal-blue:bluefin:43"

## Passed:

- display-environment
- display-versions
- install-gomplate
- install-viteplus
- install-rust
- install-uv
- install-wasmer
- install-kubectl
- install-java
- install-kotlin
- install-scala
- install-go
- install-ruby
- install-rails
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
