# GoClaw on Kubernetes — Terraform + Terragrunt

Infrastructure as Code for deploying GoClaw on GKE using Terraform modules orchestrated by Terragrunt, with state stored in GCS.

## Architecture Overview

- **GKE** (Autopilot or Standard with preemptible nodes)
- **PostgreSQL** (Cloud SQL for production, in-cluster for staging)
- **Artifact Registry** for container images
- **GCS** for Terraform state + backups
- **Workload Identity** for secure pod-to-GCP access
- **Cloud SQL Proxy** for private database connections

## Repository Structure

```
infrastructure/
├── terragrunt.hcl                    # Root config (remote state, provider)
├── env/
│   ├── staging/
│   │   ├── env.hcl                   # Staging env vars
│   │   ├── gke.hcl                   # Staging GKE config
│   │   └── terragrunt.hcl            # Staging overrides
│   └── production/
│       ├── env.hcl                   # Production env vars
│       ├── gke.hcl                   # Production GKE config
│       └── terragrunt.hcl            # Production overrides
├── modules/
│   ├── gke/                          # GKE cluster module
│   ├── gcs/                          # GCS buckets module
│   ├── artifact-registry/           # Artifact Registry module
│   ├── iam/                          # Service accounts & IAM module
│   ├── network/                      # VPC & firewall module
│   ├── postgres/                     # Cloud SQL or in-cluster
│   └── goclaw-k8s/                  # Kubernetes resources module
├── docker/
│   └── goclaw/
│       ├── Dockerfile
│       └── cloudbuild.yaml
└── helm/
    └── goclaw/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
```

## Prerequisites

- Enable GKE API: `gcloud services enable container.googleapis.com`
- Enable Artifact Registry API
- Enable Secret Manager API
- Create GCS state buckets
- Install Terraform (>= 1.5) + Terragrunt locally
- Install kubectl + gcloud CLI

## Quick Start

```bash
# Staging
cd infrastructure/env/staging
terragrunt run-all apply

# Production
cd infrastructure/env/production
terragrunt run-all apply
```

## Cost Comparison

| Component     | VM (Current)      | GKE Autopilot       | GKE Standard (Preemptible) |
|---------------|-------------------|---------------------|----------------------------|
| Compute       | ~$40/mo           | ~$30/mo             | ~$15/mo                    |
| PostgreSQL    | Included          | Cloud SQL ~$7/mo    | In-cluster ~$5/mo          |
| Storage       | 50GB PD included  | 20Gi PVC ~$2/mo     | 20Gi PVC ~$1/mo            |
| LoadBalancer  | N/A               | ~$18/mo             | ~$18/mo                    |
| Total         | ~$40/mo           | ~$57/mo             | ~$39/mo                    |

**Staging recommendation:** GKE Standard + preemptible + in-cluster PostgreSQL
**Production recommendation:** GKE Autopilot + Cloud SQL for HA

## Implementation Phases

1. **Foundation** (1-2 days): GCS buckets, root config, IAM, Artifact Registry
2. **Network + GKE** (1-2 days): VPC secondary ranges, GKE cluster, Docker image
3. **Application** (1-2 days): K8s resources, PostgreSQL, GoClaw deployment
4. **Migration** (1 day): Backup VM data, restore to K8s, verify
5. **Production** (1-2 days): Production config, migrate, switch traffic, monitor

## Security

- All secrets via environment variables or Secret Manager (never committed to repo)
- Workload Identity for pod-to-GCP access
- Private GKE clusters
- Cloud SQL private IP only
- Network policies restrict pod-to-pod communication

## License

See [LICENSE](LICENSE) for details.
