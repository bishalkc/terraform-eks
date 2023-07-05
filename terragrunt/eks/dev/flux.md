### Flux bootstrapping

```shell
export GITHUB_USER="test" ### user your github user
```
```shell
export GITHUB_TOKEN="adfadfadsfa-adfadsf-adfds" ### Please refer here to generate [PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)
```
```shell
export GITHUB_FLUX_REPO="demo-flux"
```
```shell
export GITHUB_APP_REPO="https://github.com/bishalkc/demo-app"
```
```shell
export GITHUB_FLUX_REPO="https://github.com/bishalkc/demo-flux"
```

### Bootstrap Flux
```shell
flux bootstrap github --components-extra=image-reflector-controller,image-automation-controller --owner=$GITHUB_USER --repository=$GITHUB_FLUX_REPO --path=clusters/demo-app-dev --personal
```

### Create GIT Credentials for APPLICATION
```shell
flux create secret git git-app-https-credentials \
    --url=$GITHUB_APP_REPO \
    --username=$GITHUB_USER \
    --password=$GITHUB_TOKEN
```

### Create GIT Credentials for FLUX REPO
```shell
flux create secret git demo-flux-https-credentials \
    --url=$GITHUB_FLUX_REPO \
    --username=$GITHUB_USER \
    --password=$GITHUB_TOKEN
```

### Create Credentials for SLACK Notifications
```shell
kubectl -n flux-system create secret generic slack-url \
--from-literal=address=https://hooks.slack.com/services/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
```
