# run this as root
#download it
curl -o /root/amazon-cloudwatch-agent.deb https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb
#install it
dpkg -i -E /root/amazon-cloudwatch-agent.deb
# add the cwagent user to the adm group so it can read logs
usermod -aG adm cwagent
# configure the user credentials
cat <<EOF > /home/cwagent/.aws/credentials
[AmazonCloudWatchAgent]
aws_access_key_id = aaaaaaaa
aws_secret_access_key = bbbbbbbb
EOF
# configure the user region
cat <<EOF > /home/cwagent/.aws/config
[AmazonCloudWatchAgent]
output = text
region = us-east-1
EOF
# get your own IAM creds for an IAM user and edit the file
nano /home/cwagent/.aws/credentials
# set ownership
chmod -R cwagent.cwagent /home/cwagent



