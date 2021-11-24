# This script requires installation of aws-vault, awscli to run commands.

# Login
awslogin() {
  unset AWS_VAULT
  aws-vault exec $1 --
}

#Logout
awslogout() { # Logout (clear)
  unset AWS_VAULT
  aws-vault clear
}

# Caller Identity
aws_caller(){
  aws sts get-caller-identity
}

# EC2
aws_ec2() {
  aws ec2 describe-instances  --query "Reservations[*].Instances[*].{InstanceId:InstanceId,PublicIP:PublicIpAddress,PrivateIp:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --filters Name=instance-state-name,Values=running --output table
}

# Subnets
aws_subnets() {
  aws ec2 describe-subnets --output table
}

# RDS
aws_rds() {
  aws rds describe-db-clusters --query "DBClusters[*].{Status:ActivityStreamStatus,Endpoint:Endpoint}" --output table
}

# SSM
aws_ssm() {
  aws ssm start-session --target "${1//[^A-z0-9\-]/}" --document-name AWS-StartInteractiveCommand --parameters command="bash"
}

# IAM Roles
aws_roles() {
  aws iam list-roles --query "Roles[*].{RoleId:RoleId,Name:RoleName,CreatedAt:CreateDate}" --output=table
}

# IAM Policies
aws_policies() {
  aws iam list-policies --query "Policies[*].{Name:PolicyName,Id:PolicyId,Attachable:IsAttachable,UpdatedAt:UpdateDate}" --output=table
}

# AWS EKS Cluster Auth
aws_eks_list() {
  aws eks list-clusters --output=table
}
aws_eks_update_conf() {
  aws eks update-kubeconfig --region ap-northeast-2 $1
}

aws_ecr_list() {
  aws ecr describe-repositories --query="repositories[*].{URI:repositoryUri,Name:repositoryName,Mutable:imageTagMutability}" --output=table
}

# AWS VPC
aws_vpc_list() {
  aws ec2 describe-vpcs --query="Vpcs[*].{VpcId:VpcId,OwnerId:OwnerId,CidrBlock:CidrBlock}" --output=table
}

alias al="awslogin"
alias all="awslogout"
alias aws-list="aws-vault list"
alias ec2="aws_ec2"
alias ssm="aws_ssm"
alias aws-cost="aws ce get-cost-and-usage --time-period Start=$(date +%Y-%m-01),End=$(date -v+1m +%Y-%m-01) --metric "BlendedCost" --granularity MONTHLY" # Cost explorer
