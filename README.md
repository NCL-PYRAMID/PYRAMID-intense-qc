# PYRAMID-intense-qc
Application of Intense QC rainfall measurement quality control methods to DAFNI data

## About
Applies QC methods to rainfall guage data


### Project Team
Amy Green, Newcastle University  ([amy.green3@newcastle.ac.uk](mailto:amy.green3@newcastle.ac.uk))  
Elizabeth Lewis, Newcastle University  ([elizabeth.lewis2@newcastle.ac.uk](mailto:elizabeth.lewis2@newcastle.ac.uk))  

### RSE Contact
Robin Wardle  
RSE Team, Newcastle Data  
Newcastle University NE1 7RU  
([robin.wardle@newcastle.ac.uk](mailto:robin.wardle@newcastle.ac.uk))  

## Built With

[Python 3](https://www.python.org)  

[Docker](https://www.docker.com)  

Other required tools: [tar](https://www.unix.com/man-page/linux/1/tar/), [zip](https://www.unix.com/man-page/linux/1/gzip/).

## Getting Started

### Prerequisites
TBC

### Installation
TBC

### Running Locally
TBC

### Running Tests
TBC

## Deployment

### Local
A local Docker container that mounts the test data can be built and executed using:

```
docker build . -t pyramid-intense-qc -f Dockerfile
docker run -v "$(pwd)/data:/data" pyramid-intense-qc
```

Note that output from the container, placed in the `./data` subdirectory, will have `root` ownership as a result of the way in which Docker's access permissions work.

### Production
#### DAFNI upload
The model is containerised using Docker, and the image is _tar_'ed and _zip_'ed for uploading to DAFNI. Use the following commands in a *nix shell to accomplish this.

```
docker build . -t pyramid-intense-qc -f Dockerfile
docker save -o pyramid-intense-qc.tar pyramid-intense-qc:latest
gzip pyramid-intense-qc.tar
```

The `pyramid-intense-qc.tar.gz` Docker image and accompanying DAFNI model definintion file (`model-definition.yaml`) can be uploaded as a new model using the "Add model" facility at [https://facility.secure.dafni.rl.ac.uk/models/](https://facility.secure.dafni.rl.ac.uk/models/).

## Usage
The deployed model can be run in a DAFNI workflow. See the [DAFNI workflow documentation](https://docs.secure.dafni.rl.ac.uk/docs/how-to/how-to-create-a-workflow) for details.


## Roadmap
- [x] Initial Research  
- [x] Minimum viable product <-- You are Here  
- [ ] Alpha Release  
- [ ] Feature-Complete Release  

## Contributing
The PYRAMID project has ended. All pull requests will be ignored.

## License
TBD

## Acknowledgements
This work was funded by NERC, grant ref. NE/V00378X/1, “PYRAMID: Platform for dYnamic, hyper-resolution, near-real time flood Risk AssessMent Integrating repurposed and novel Data sources”. See the project funding [URL](https://gtr.ukri.org/projects?ref=NE/V00378X/1).
