# resource "aws_instance" "higa-ec2-1" {

#   tags = {
#     Name = "higa-ec2-1"
#     Dlm  = "higa-ec2-BackUp"
#   }

#   ami                    = "ami-0bd6906508e74f692" # Amazon Linux 2
#   instance_type          = "t2.micro"
#   subnet_id              = aws_subnet.higa-Public-subnet-1a.id
#   vpc_security_group_ids = [aws_security_group.higa-ec2-sg.id]
#   private_ip             = "10.0.1.10"
#   key_name               = "higa1-keypair"
#   iam_instance_profile   = "higa_profile"

#   //キャパシティー予約をなしに設定
#   capacity_reservation_specification {
#     capacity_reservation_preference = "none"
#   }

#   # EBSのルートボリューム設定
#   root_block_device {
#     // ボリュームサイズ(GiB)
#     volume_size = 8
#     // ボリュームタイプ
#     volume_type = "gp3"
#     // GP3のIOPS
#     iops = 3000
#     // GP3のスループット
#     throughput = 125
#     // EC2終了時に削除
#     delete_on_termination = true

#     // 暗号化KMS設定
#     encrypted  = true
#     kms_key_id = aws_kms_key.higa_KMS.key_id

#     // EBSのNameタグ
#     tags = {
#       Name = "higa-gp3-dev-ec2"
#     }
#   }