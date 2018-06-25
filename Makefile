ORG=khanlab
NAME=prepdwi
VERSION = 0.0.7g

SINGULARITY_NAME=$(ORG)_$(NAME)_$(VERSION)
DOCKER_NAME=$(ORG)/$(NAME):$(VERSION)
DOCKER_LATEST=$(ORG)/$(NAME):latest

BUILD_DIR=~/singularity
REMOTE_BUILD_DIR=~/graham/singularity/bids-apps
LOG_DIR=build_logs

LOCAL_UUID=9bc03c00-89ae-11e7-a97f-22000a92523b
GRAHAM_SINGULARITY_UUID=42df491c-52e1-11e8-9060-0a6d4e044368

fromlocal:
	mkdir -p $(LOG_DIR)
	mkdir -p $(BUILD_DIR)
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img local.Singularity.$(VERSION) | tee $(LOG_DIR)/build_$(SINGULARITY_NAME).log
	globus transfer $(LOCAL_UUID):$(BUILD_DIR)/$(SINGULARITY_NAME).img $(GRAHAM_SINGULARITY_UUID):bids-apps/$(SINGULARITY_NAME).img


build:
	mkdir -p $(LOG_DIR)
	mkdir -p $(BUILD_DIR)
	rm -f $(BUILD_DIR)/$(SINGULARITY_NAME).img
	sudo singularity build $(BUILD_DIR)/$(SINGULARITY_NAME).img Singularity.$(VERSION) | tee $(LOG_DIR)/build_$(SINGULARITY_NAME).log
	globus transfer $(LOCAL_UUID):$(BUILD_DIR)/$(SINGULARITY_NAME).img $(GRAHAM_SINGULARITY_UUID):bids-apps/$(SINGULARITY_NAME).img


sandbox:
	mkdir -p $(LOG_DIR)
	mkdir -p $(BUILD_DIR)
	rm -rf $(BUILD_DIR)/sandbox_$(SINGULARITY_NAME).img
	sudo singularity build --sandbox $(BUILD_DIR)/sandbox_$(SINGULARITY_NAME) Singularity.$(VERSION) | tee -a $(LOG_DIR)/sandbox_$(SINGULARITY_NAME).log
	sudo chmod a+rwX -R $(BUILD_DIR)/sandbox_$(SINGULARITY_NAME)
	
docker_build: 
	docker build -t $(DOCKER_NAME) --rm .


clean_test:
	rm -rf dwi_singleshell dwi_singleshell_out

test_singleshell:
	mkdir dwi_singleshell
	wget -qO- https://www.dropbox.com/s/68oez1yhhnqp7z2/dwi_singleshell.tar | tar xv -C dwi_singleshell
	docker run --rm -it -v $(PWD)/dwi_singleshell:/in -v $(PWD)/dwi_singleshell_out:/out $(DOCKER_NAME) /in /out participant --no-bedpost
	test -f dwi_singleshell_out/prepdwi/sub-001/dwi/sub-001_dwi_space-T1w_preproc.nii.gz  
	test -f dwi_singleshell_out/prepdwi/sub-001/dwi/sub-001_dwi_space-T1w_preproc.bvec
	test -f dwi_singleshell_out/prepdwi/sub-001/dwi/sub-001_dwi_space-T1w_preproc.bval
	test -f dwi_singleshell_out/prepdwi/sub-001/dwi/sub-001_dwi_space-T1w_proc-FSL_FA.nii.gz
	test -f dwi_singleshell_out/prepdwi/sub-001/dwi/sub-001_dwi_space-T1w_proc-FSL_V1.nii.gz
	test -f dwi_singleshell_out/prepdwi/sub-001/dwi/sub-001_dwi_space-T1w_brainmask.nii.gz

docker_tag_latest:
	docker tag $(DOCKER_NAME) $(DOCKER_LATEST)

docker_push:
	docker push $(DOCKER_NAME)

docker_push_latest:
	docker push $(DOCKER_LATEST)

docker_run:
	docker run --rm -it $(DOCKER_NAME) /bin/bash	

docker_last_built_date:
	docker inspect -f '{{ .Created }}' $(DOCKER_NAME)

