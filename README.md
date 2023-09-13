# Deploy container to ECS

## Disclaimer

I believe there are a lot of things that can be improve in this solution. Since it has been a  long time I haven't use aws nor github action. I mostly use azure + gitlab-ci. So if you have any things on your mind, any improment that could be make, please let me know! :smiley:

## Planning

From the begining, I created an IAM user with full access (*bad practice* :smiley:) on: **vpc**, **alb**, **ecr**, **ecs** and a role with **ecsTaskExecutionRole**. 

I planned to use terraform for the creation of IAM but then I decided to create it manually since this action will be execute only one time.

Next, I made a plan to design the CI pipeline on how to deploy the the container to the ecs.

There were 2 solutions that I think of:

- I can a job to create the **vpc**, **alb**, **ecr** and **ecs cluster**. then make a job for docker build, push to the **ecr**. Then last is make a job for the **ecs task** to deploy the image.

- I can use 2 providers in terraform, **aws** and **docker** providers. Next, I use docker provider to build and push the image within terraform. 

I decided to go with the second solution due to the simplication.

Next, I wrote code for the app, create dockerfile, then made a design for the terraform scripts. After that, I create the backend for the terraform.

From the begining, I was going with the Terraform Cloud, but unfortunately it does not support the docker provider, hence I decided to move to use the s3 bucket.

Last, I create the gitlab action file with 3 main concepts:
    - check format of the terraform script.
    - check if the s3 bucket exists?
        - if not, create the s3 bucket then init it as new backend for the infrastructure. 
        - If yes, move to the next step
    - create the infrastructure for the deployment.

## Actions

There are 4 main folders:

- app (contains a small python code with dockerfile)
- backend (s3 bucket as container for terraform state backend)
- infras (contains infrastructure for the deployment of ecs)
- .github/workflow/ (contains action files)

Next:
- Create the application folder
- create the terraform script for backend
- create the terraform script for infrastructure
- github action script

## What could I have done better

- Setup better roles and permissions for the IAM
- Go with the first solution, separate the infrastructure repo and application code repo. Better workflow for the deployment.
- Create enviroments (dev/prod) on github, hence, I can create manual job for terraform apply instead for --auto-approve.

Please let me know if there is anything I can improve. Looking forward to your reply! :smiley:



