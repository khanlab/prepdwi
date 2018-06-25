ORG=khanlab
NAME=prepdwi
VERSION = 0.0.7g

SINGULARITY_NAME=$(ORG)_$(NAME)_$(VERSION)

BUILD_DIR=~/singularity
REMOTE_BUILD_DIR=~/graham/singularity/bids-apps
LOG_DIR=build_logs

fromlocal:
	mkdir -p $(LOG_DIR)
	mkdir -p $(BUILD_DIR)
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img local.Singularity.$(VERSION) | tee $(LOG_DIR)/build_$(SINGULARITY_NAME).log
	cp -vf $(BUILD_DIR)/$(SINGULARITY_NAME).img $(REMOTE_BUILD_DIR)/$(SINGULARITY_NAME).img


build:
	mkdir -p $(LOG_DIR)
	mkdir -p $(BUILD_DIR)
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img Singularity.$(VERSION) | tee $(LOG_DIR)/build_$(SINGULARITY_NAME).log
	cp -vf $(BUILD_DIR)/$(SINGULARITY_NAME).img $(REMOTE_BUILD_DIR)/$(SINGULARITY_NAME).img


sandbox:
	mkdir -p $(LOG_DIR)
	mkdir -p $(BUILD_DIR)
	rm -rf $(BUILD_DIR)/sandbox_$(SINGULARITY_NAME).img
	sudo singularity build --sandbox $(BUILD_DIR)/sandbox_$(SINGULARITY_NAME) Singularity.$(VERSION) | tee -a $(LOG_DIR)/sandbox_$(SINGULARITY_NAME).log
	sudo chmod a+rwX -R $(BUILD_DIR)/sandbox_$(SINGULARITY_NAME)
	

