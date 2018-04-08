ORG=khanlab
NAME=prepdwi
VERSION = 0.0.6b

SINGULARITY_NAME=$(ORG)_$(NAME)_$(VERSION)

BUILD_DIR=~/singularity
REMOTE_BUILD_DIR=~/graham/singularity/bids-apps
LOG_DIR=build_logs

fromlocal:
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img local.Singularity.$(VERSION) | tee $(LOG_DIR)/build_$(SINGULARITY_NAME).log
	cp -vf $(BUILD_DIR)/$(SINGULARITY_NAME).img $(REMOTE_BUILD_DIR)/$(SINGULARITY_NAME).img


build:
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img Singularity.$(VERSION) | tee $(LOG_DIR)/build_$(SINGULARITY_NAME).log
	cp -vf $(BUILD_DIR)/$(SINGULARITY_NAME).img $(REMOTE_BUILD_DIR)/$(SINGULARITY_NAME).img


sandbox:
	sudo singularity build --sandbox sandbox_$(SINGULARITY_NAME) Singularity | tee -a $(LOG_DIR)/sandbox_$(SINGULARITY_NAME).log
	

