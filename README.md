## Checkmarx - Application Security Testing Developers Actually Use
[![Docker Pulls](https://img.shields.io/docker/pulls/rvannauker/checkmarx.svg)](https://hub.docker.com/r/rvannauker/checkmarx/) [![Docker Stars](https://img.shields.io/docker/stars/rvannauker/checkmarx.svg)](https://hub.docker.com/r/rvannauker/checkmarx/) [![](https://images.microbadger.com/badges/image/rvannauker/checkmarx:latest.svg)](https://microbadger.com/images/rvannauker/checkmarx:latest) [![GitHub issues](https://img.shields.io/github/issues/RichVRed/docker-checkmarx.svg)](https://github.com/RichVRed/docker-checkmarx) [![license](https://img.shields.io/github/license/RichVRed/docker-checkmarx.svg)](https://tldrlegal.com/license/mit-license)

Docker container to install and run checkmarx

### Installation / Usage
1. Install the rvannauker/checkmarx container:
```bash
docker pull rvannauker/checkmarx
```
2. Run checkmarx through the checkmarx container:
```bash
sudo docker run -v ${PWD}:/usr/src --net=host "rvannauker/checkmarx" Scan -CxServer {server} -ProjectName {projectName} -CxUser {username} -CxPassword {password} -Incremental -LocationType {location_type} -LocationPath {location_path} -LocationPathExclude "{exclude_paths}" -v
```

### Download the source:
To run, test and develop the CHECKMARX Dockerfile itself, you must use the source directly:
1. Download the source:
```bash
git clone https://github.com/RichVRed/docker-checkmarx.git
```
2. Build the container:
```bash
sudo docker build --force-rm --tag "rvannauker/checkmarx" --file checkmarx.dockerfile .
```
3. Test running the container:
```bash
 $ docker run rvannauker/checkmarx --help
```