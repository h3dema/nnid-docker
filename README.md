# nnid-docker
Allows to create a docker container to develop NNI (from Microsoft). See in [this link](https://github.com/h3dema/nni) my version.


## to build:

```
git clone https://github.com/h3dema/nnid-docker.git
cd nnid-docker
docker build -t nni .
```

## to run:

Runs the container and opens a root prompt, so you can alter or run the NNI.

```
docker run -p 8080:8080 -v "$(pwd)":/DATA  -it nni
```

Inside the docker container, you can try one example:

```
cd nni/examples/trials/mnist-keras/
nnictl create --config config.yml
nnictl trial ls
nnictl experiment show
```
