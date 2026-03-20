# Load .env file if it exists
set dotenv-load := true

# Global variables
export BIN_DIR := HOME + "/.local/bin"

# Ensure BIN_DIR is in PATH for this session
export PATH := BIN_DIR + ":" + env_var('PATH')

# Default recipe lists available commands
default:
    @just --list

# Include modular justfiles
# !include "justfiles/tools.just"
