# template variables
name_prefix = "auto-scaling-web-template"
image_id = "ami-05a1ab21ccdfbf689"
instance_type = "t2.micro"
key_name = "abhilash-2ac"
#vpc_security_group_ids = ""

# Auto Scaling
auto_name = "auto-scaling-group"
max_size              = 4
min_size              = 1
desired_capacity      = 2
asg_health_check_type = "ELB"
target_group_arns     = []
project = "kalpana_auto"
health_check_grace_period = "30"
vpc_zone_identifier = "subnet-04adf9a5095245da8"

# scale up policy
scale_up_scaling_adjustment = "1"
scale_up_cooldown = "30"
scale_up_policy_type = "SimpleScaling"

# aws scale up cloudwatch alarm
scale_up_alarm_description = "asg-scale-up-cpu-alarm"
scale_up_comparison_operator = "GreaterThanOrEqualToThreshold"
scale_up_evaluation_periods = "2"
scale_up_metric_name = "CPUUtilization"
scale_up_namespace = "AWS/EC2"
scale_up_period = "30"
scale_up_statistic = "Average"
scale_up_threshold = "1"

# scale down policy
scale_down_scaling_adjustment = "-1"
scale_down_cooldown = "30"
scale_down_policy_type = "SimpleScaling"

# aws scale down cloudwatch alarm
scale_down_alarm_description = "asg-scale-down-cpu-alarm"
scale_down_comparison_operator = "LessThanOrEqualToThreshold"
scale_down_evaluation_periods = "2"
scale_down_metric_name = "CPUUtilization"
scale_down_namespace = "AWS/EC2"
scale_down_period = "30"
scale_down_statistic = "Average"
scale_down_threshold = "50"
