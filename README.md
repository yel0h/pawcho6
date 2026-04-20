# Docker - BuildKit

## Utworzenie repo w gh

```bash
gh repo create pawcho6 --public --source=. --remote=origin --push
```

Wynik:

```
✓ Created repository yel0h/pawcho6 on github.com
  https://github.com/yel0h/pawcho6
✓ Added remote https://github.com/yel0h/pawcho6.git
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 3.55 MiB | 1.93 MiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To https://github.com/yel0h/pawcho6.git
 * [new branch]      HEAD -> main
branch 'main' set up to track 'origin/main'.
✓ Pushed commits to https://github.com/yel0h/pawcho6.git
```

## Zmodyfikowany [Dockerfile](Dockerfile)

## Budowanie obrazu

```bash
export DOCKER_BUILDKIT=1
docker build --ssh default -t ghcr.io/yel0h/pawcho6:lab6 .
```

Wynik:

```
[+] Building 11.8s (16/16) FINISHED                                                                      docker:default
 => [internal] load build definition from Dockerfile                                                               0.0s
 => => transferring dockerfile: 1.22kB                                                                             0.0s
 => [internal] load metadata for docker.io/library/nginx:alpine                                                    0.8s
 => [internal] load metadata for docker.io/library/alpine:latest                                                   0.8s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => CACHED [source 1/4] FROM docker.io/library/alpine:latest@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e  0.0s
 => => resolve docker.io/library/alpine:latest@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019a  0.0s
 => CACHED [stage-2 1/3] FROM docker.io/library/nginx:alpine@sha256:5616878291a2eed594aee8db4dade5878cf7edcb475e5  0.0s
 => => resolve docker.io/library/nginx:alpine@sha256:5616878291a2eed594aee8db4dade5878cf7edcb475e59193904b198d9b8  0.0s
 => [internal] load build context                                                                                  0.0s
 => => transferring context: 59B                                                                                   0.0s
 => [builder 1/3] ADD alpine-minirootfs-3.23.3-x86_64.tar /                                                        0.1s
 => [stage-2 2/3] RUN rm -rf /usr/share/nginx/html/*                                                               0.4s
 => [source 2/4] RUN apk add --no-cache git openssh                                                                5.0s
 => [source 3/4] RUN mkdir -p -m 0700 /root/.ssh &&     ssh-keyscan github.com >> /root/.ssh/known_hosts           1.7s
 => [source 4/4] RUN --mount=type=ssh     git clone git@github.com:yel0h/pawcho6.git /repo                         3.4s
 => [builder 2/3] COPY --from=source /repo /app                                                                    0.1s
 => [builder 3/3] RUN IP=$(hostname -i) &&     HOST=$(hostname) &&     echo "<!DOCTYPE html>" > /index.html &&     0.2s
 => [stage-2 3/3] COPY --from=builder /index.html /usr/share/nginx/html/index.html                                 0.1s
 => exporting to image                                                                                             0.2s
 => => exporting layers                                                                                            0.1s
 => => exporting manifest sha256:d0d111ad158730269d793022a67077ec4c49a9855d0a2d71c3d8338407fc30ca                  0.0s
 => => exporting config sha256:1b33a6c959d174c618332861a598ab4d4f490bc0ee92ef87d08db675bef23cca                    0.0s
 => => exporting attestation manifest sha256:09ab6a96562e60e37dc360da98d0681258a415ab304a6c9fc1941d9443d9b95c      0.0s
 => => exporting manifest list sha256:6cd33c21258371bc617733f3b2a8fdb31fb482774a2dbac451fab1c18cf6700d             0.0s
 => => naming to ghcr.io/yel0h/pawcho6:lab6                                                                        0.0s
 => => unpacking to ghcr.io/yel0h/pawcho6:lab6                                                                     0.0s
```

## Przesłanie obrazu

```bash
docker push ghcr.io/yel0h/pawcho6:lab6
```

Wynik:

```
The push refers to repository [ghcr.io/yel0h/pawcho6]
6a0ac1617861: Pushed
82736a35d0e7: Pushed
4a8b0b2a5b19: Pushed
4f5a8b6f80d4: Pushed
8056aa5715b4: Pushed
781ff50d2644: Pushed
583599bb7d38: Pushed
aee4e54b3865: Pushed
453da7dbc73e: Pushed
612c0c1df4c5: Pushed
85a3c659d6a2: Pushed
lab6: digest: sha256:6cd33c21258371bc617733f3b2a8fdb31fb482774a2dbac451fab1c18cf6700d size: 856
```

## Powiązane [repozytorium](https://github.com/yel0h/pawcho6/pkgs/container/pawcho6)
