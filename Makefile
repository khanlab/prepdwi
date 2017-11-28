ORG=khanlab
NAME=prepdwi
VERSION = 0.0.1

SINGULARITY_NAME=$(ORG)_$(NAME)_$(VERSION)

BUILD_DIR=~/singularity
REMOTE_BUILD_DIR=~/graham/singularity

build:
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img Singularity | tee build_$(SINGULARITY_NAME).log
	cp -vf $(BUILD_DIR)/$(SINGULARITY_NAME).img $(REMOTE_BUILD_DIR)/$(SINGULARITY_NAME).img


sandbox:
	sudo singularity build --sandbox sandbox_$(SINGULARITY_NAME) Singularity | tee -a sandbox_$(SINGULARITY_NAME).log
	

