ai_infra/
.
├── .gitignore
├── azure-pipelines.yml             <-- Stays at root
├── templates/                      <-- Move this to root
│   └── terraform-steps.yml
└── ai_infra/
    └── backend-infra/
        ├── local.tf
        ├── network.tf
        ├── outputs.tf
        ├── provider.tf
        ├── resource_group.tf
        ├── security_group.tf
        └── vm.tf
