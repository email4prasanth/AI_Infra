```sh
git add .
git commit -m "add multi-branch build infra pipelines"
git push origin dev
```

- Register the Main Pipeline (If you haven't already)
    - Go to Pipelines > Pipelines in Azure DevOps.
    - Click New pipeline -> Select your repo source -> Select your repo.
    - Choose Existing Azure Pipelines YAML file.
    - Change the branch dropdown to dev (since your code is there) and select /azure-pipelines.yml instead, then save it as AI-Infra-Deployment.