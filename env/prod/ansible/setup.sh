export TF_OUTPUT_PUBLIC_DNS=$(terraform output public_dns)

echo "[ec2_instances]" > hosts
echo "${TF_OUTPUT_PUBLIC_DNS} ansible_ssh_private_key_file=../.key_pair/botapeer-prod-server.id_rsa" >> hosts