module "mod_jenkins" {
    source = "./modules/mod_jenkins"
    vpc_id = data.aws_vpc.my-vpc.id
    ami = data.aws_ami.ubuntu.id
    
    subnet_cidr = "10.0.102.0/24"
    prefix_name = "Exercicio.02"
    your_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC1AaRc9FJ1kLIZcR2i7HKO6j8PZbHsW/uId/Tck3M4O8RH4WIEhcX2NpiUvcleyCeUX8kg/VJh3Imp8CjYBhAxEpL/MxKW3TsGoj9yEX1PmCsyOackzjNSVwDN94PaBjRKuV1AmfBZvaoHzK8WkAt6ldIS7sHRNRu3jwcTzJmp/evOvhJoXcCF4KF8JM7v1Bm3VQXY+FWAugW4JfYpY/CBQYtZxmsn8jUL8aSdopGiQSKCyx5YRMPu9j8J/1ClS3TXJG2jjFD+EvEhnig/k6H6qu4RLSRbTiSUp82Gajpoc0sv8E2h4YVDk8bjJrVeMcxL1yMcVv2oQvvWQemhiBVIqBbjcnWaUWBU9ugRtE4216wtVWzD8QziZ6HpXGTUXq4eStNWqCFcC+03DclNosYOv45IJY31XOzpwOCq7/5NWAtkrVoZvgN5SG1iurtQ/wejQ/kOJDImEKaQxXFlYf7SQu/4zWzaEzAFADk4pYIrTXfTI6hbK2Cl7TGY2Xuum7s="
    shape_app = "t2.small"
    tags = {
	    Faculdade = "Impacta"
        Modulo = "Cloud Automation"
    }
}

resource "null_resource" "PassJenkins" {
    triggers = {
        instance = module.mod_jenkins.jenkins-app
    }
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("${path.module}/modules/mod_jenkins/userData/id_jenkins")
        host = module.mod_jenkins.jenkins-app
    }
    provisioner "remote-exec" {
    inline = [
        "sleep 200",
        "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
    ]
  }
}

output "jenkinsIP" {
    value = module.mod_jenkins.jenkins-app
}

