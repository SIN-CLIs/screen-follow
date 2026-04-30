EXECUTABLE_NAME = screen-follow
BUILD_DIR = .build/release
INSTALL_PATH = $(HOME)/.local/bin

.PHONY: build install uninstall clean run

build:
	swift build -c release --disable-sandbox

install: build
	cp $(BUILD_DIR)/$(EXECUTABLE_NAME) $(INSTALL_PATH)/$(EXECUTABLE_NAME)
	@echo "✅ Installed to $(INSTALL_PATH)/$(EXECUTABLE_NAME)"

uninstall:
	rm -f $(INSTALL_PATH)/$(EXECUTABLE_NAME)

clean:
	swift package clean
	rm -rf $(BUILD_DIR)

run: build
	$(BUILD_DIR)/$(EXECUTABLE_NAME)
