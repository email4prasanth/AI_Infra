```sh
git add .
git commit -m "feat: add multi-branch pipelines and separate destroy pipeline"
git push origin dev
```
- Register the Destroy Pipeline
    - Go to Pipelines > Pipelines in Azure DevOps.
    - Click New pipeline -> Select your repo source -> Select your repo.
    - Choose Existing Azure Pipelines YAML file.
    - Change the branch dropdown to dev (since your code is there) and select /azure-pipelines-destroy.yml.
    - Click the down arrow next to Run and hit Save. Rename this pipeline to AI-Infra-Teardown.