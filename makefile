# The directories for the source files
MD_DIR      := src/
CSS_DIR     := css/
DATA_DIR	:= data/
DEFAULT_CSS := $(CSS_DIR)styles.css

# directory for the compiled html
BUILD_DIR   := build/

# Pandoc compilation extensions
BUILD_OPTS	:= 

# host for uploading/syncing changes with remote server
# along with directory for the upload
UPLOAD_HOST := user@example.com
UPLOAD_PATH := /path/to/directory

# all source files
MD_FILES    := $(shell find $(MD_DIR) -type f -name "*.md")
HTML_FILES  := $(patsubst $(MD_DIR)%.md,$(BUILD_DIR)%.html,$(MD_FILES))
CSS_FILES   := $(patsubst $(CSS_DIR)%,$(BUILD_DIR)$(CSS_DIR)%, \
			   $(wildcard $(CSS_DIR)*.css))

.PHONY: all clean sync test

# build site, copy data and favicon to the build dir
all: $(CSS_FILES) $(HTML_FILES)
	cp -rf $(MD_DIR)$(DATA_DIR) $(BUILD_DIR)$(DATA_DIR)
	cp $(MD_DIR)favicon.ico $(BUILD_DIR)favicon.ico

# build css stylesheets
$(BUILD_DIR)$(CSS_DIR)%.css: $(CSS_DIR)%.css
	if [ ! -d "$(@D)" ]; then mkdir -p "$(@D)"; fi
	cp $< $@

# build html pages
$(BUILD_DIR)%.html: $(MD_DIR)%.md
	if [ ! -d "$(@D)" ]; then mkdir -p "$(@D)"; fi
	pandoc -s -c $(shell sed 's/[^/]//g; s/\//..\//g' <<<$(@D))$(DEFAULT_CSS) -f markdown$(BUILD_OPTS) -o "$@" "$<"

# copy data dir to build dir
$(BUILD_DIR)$(DATA_DIR)%: $(MD_DIR)$(DATA_DIR)%
	if [ ! -d "$(@D)" ]; then mkdir -p "$(@D)"; fi
	cp -rf $(DATA_DIR) $(BUILD_DIR)

# test local verson and open in browser
test: all
	xdg-open $(BUILD_DIR)index.html > /dev/null 2>&1 &

# sync built changes to remote server
sync: $(HTML_FILES)
	rsync -rtvzP $(BUILD_DIR) $(UPLOAD_HOST):$(UPLOAD_PATH)

# clean build files
clean:
	rm -rf $(BUILD_DIR)
