.PHONY: test lint format

test:
	nvim --clean --headless --cmd "set rtp^=$(CURDIR)" -l tests/check.lua

lint:
	stylua --check lua tests

format:
	stylua lua tests
