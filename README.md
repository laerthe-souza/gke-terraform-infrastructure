# GKE Infrastructure

## This project will help you to up a infrastructure in Google Cloud Platform with just a few commands using Terraform

#### Tools you need to set up your infrastructure:
- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- [KubeCTL](https://kubernetes.io/docs/tasks/tools)
<hr>

#### Setting up Google Cloud Platform:

1. Create an account on [Google Cloud Platform](https://cloud.google.com)
2. Create a service account by navigating to `Navigation Menu > IAM & Admin > Service Accounts > Create Service Account`. Select the `Compute Engine Service Agent` and `Kubernetes Engine Service Agent` roles for this service account.
3. After creating a service account, generate credentials. Access your service account, navigate to `KEYS`, and create a new key in JSON format.

<hr>

#### Setting up Cloudflare:

1. Create an account on [Cloudflare](https://dash.cloudflare.com/sign-up). Cloudflare offers a free plan.
2. Add a new website, to do this, you should have a registered domain. Learn more by watching this [video](https://www.youtube.com/watch?v=3p-BIkqJdFg).
3. After creating the website, in the overview section, copy the two nameservers. Go to the site where you bought your domain and set up DNS. After completing this step, wait for the settings to take effect.
<hr>

#### Setting up Terraform Cloud, Terraform and create Cluster on GKE

> We will use Terraform Cloud to store terraform state in a remote storage. With centralized state, any person in your team can contribute and modify your infrastructure.

1. Create an account on [Terraform Cloud](https://app.terraform.io/public/signup/account).
2. In organization page, navigate to `Settings > Variables sets` to configure globals variables. Mark option `Apply to specific projects and workspaces` and choose what project you can grant access to this variables. Set the following variables:
    - `GOOGLE_CREDENTIALS`: The service account JSON key generated in Google Cloud Platform. This variable must be in uppercase.
    - `google_project_id`: Your Google Project ID.
3. After creating an account, run the following command in your terminal: `terraform login`.

> A variable `GOOGLE_CREDENTIALS` is a JSON file, you should run the command below to get JSON file data and parse to string before you save variable in Terraform Cloud:
```bash
cat /path/to/file.json | tr -s '\n' ' '
```

> As you can see, inside the `dev` directory, we have 3 directories (`cluster`, `kubernetes`, and `integration`).
>
> The steps below will be very similar within each of the 3 directories; the only thing that will change is the environment variables.
>
> In the `.env.example` file, we have comments indicating where the variables are used. After running the `terraform init` command within each folder, a workspace will be created in Terraform Cloud. We should configure the variables only in the corresponding workspace.
>

4. In the project, go to the `/terraform/roots/dev/cluster` directory and run `terraform init`. This command will sync with your Terraform Cloud account and create a new workspace. Remember to change the Terraform Cloud organization name in the `main.tf` file to your organization's name.
5. Navigate to the Terraform Cloud website, access the created workspace named `gke_cluster_dev`, go to `Settings`, and modify the `Terraform Working Directory` option by setting its value to `./terraform/roots/dev/cluster`.
6. Return to the root of your workspace, then go to `Variables` and configure the following variables:
    - `google_service_account_email`: Your Google Service Account email.
7. All set! Finally, you can run `terraform plan` to preview the resources that will be created and then execute `terraform apply`. Remembering that command inside directory `cluster` only create GKE with one node.
8. The `integration` workspace variables:
    - `cloudflare_email`: Email of your Cloudflare Account
    - `cloudflare_api_key`: Your Cloudflare Account api key
    - `cloudflare_zone_id`: After created a website, in the overview section you can see in right side the property `Zone ID` 
    - `cert_manager_acme_email`: An email to receive alerts about your certificate

#### Deploy manifests

In the project root, inside `k8s-manifests`, you can modify the `ingress.yaml` file and change all references of the `subdomain.domain.com.br` value to your desired value. The subdomain can be anything, but not the domain.

Run the `kubectl apply` command to apply manifests in your cluster. Remember to follow the order of the commands as shown below.
```bash
kubectl apply -f secrets.yaml
kubectl apply -f deployment.yaml
kubectl apply -f hpa.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```
Go to your web browser and try to access the domain you set up in `ingress.yaml`. If the nginx welcome page is displayed, congratulations!!!

