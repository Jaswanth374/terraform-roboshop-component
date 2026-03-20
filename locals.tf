locals {

    common_tags = {
    
            project = var.project
            environment = var.environment
            terraform = "true"
        
    }
    ami_id = data.aws_ami.ami.id
    private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]
    sg_id = data.aws_ssm_parameter.sg_id.value
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
    
    port_number = var.component == "frontend" ? 80 : 8080
    path = var.component == "frontend" ? "/" : "/health"
    listener_arn = var.component == "frontend" ? data.aws_ssm_parameter.frontend_alb_listener_arn.value : data.aws_ssm_parameter.backend_alb_listener_arn.value
    host_header = var.component == "frontend" ? "${var.component}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"
}