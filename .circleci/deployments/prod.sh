wget -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_linux_amd64.zip
wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
unzip /tmp/packer.zip -d ~/bin
unzip /tmp/terraform.zip -d ~/bin
packer validate packer-template.json &&
packer build packer-template.json &&
export TF_VAR_image_id=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITALOCEAN_API_TOKEN" "https://api.digitalocean.com/v2/images?private=true" | jq ."images[] | select(.name == \"devops-$CIRCLE_BUILD_NUM\") | .id")
export XXX=123
echo "image_id: $TF_VAR_image_id"
echo "XXX: $XXX"
echo "CIRCLE_BUILD_NUM: $CIRCLE_BUILD_NUM"
cd infra && terraform init -input=false && terraform apply -input=false -auto-approve && cd.. &&
git add infra && git commit -am "Deployed $CIRCLE_BUILD_NUM [skip ci]" &&
git push origin master