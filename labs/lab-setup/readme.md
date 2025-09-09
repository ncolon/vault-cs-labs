prepare yaml's and certs

```bash
./init.sh
```

to start your primary cluster

```bash
podman kube play vault-primary.yaml
```

to stop your cluster

```bash
podman kube down vault-primary.yaml
```

to use vault

```bash
podman exec -it vault-primary-1-vault-enterprise bash
```

to init the cluster

```bash
vault operator init
```

to unseal the cluster

```bash
vault operator unseal
```
