# Red Hat Summit Connect - Open Tech Quest - OpenShift

![image](nginx-example-app/open_tech_quest_banner.png)

## Build on Mac with Podman Destkop

### nginx

```
export IMAGE="quay.io/open-tech-quest/openshift-nginx-demo-app:$( date +%s )"
podman manifest rm ${IMAGE}
podman build --manifest ${IMAGE} \
    --platform linux/amd64,linux/arm64 .

podman manifest push ${IMAGE}
```

### initContainer
```
export IMAGE="quay.io/open-tech-quest/openshift-nginx-demo-app-init:$( date +%s )"
podman manifest rm ${IMAGE}
podman build --manifest ${IMAGE} \
    -f init.Containerfile \
    --platform linux/amd64,linux/arm64 .

podman manifest push ${IMAGE}
```
