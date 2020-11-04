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
# ensure collectd is installed
apt install collectd
# run the wizard
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
# move the configuration file to the right place and name it properly
mv /opt/aws/amazon-cloudwatch-agent/bin/config.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
# restart the service
service amazon-cloudwatch-agent restart
# check status
service amazon-cloudwatch-agent status
# check the logs
tail -f /var/log/amazon/amazon-cloudwatch-agent/amazon-cloudwatch-agent.log






