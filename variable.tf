#template variables
variable "name_prefix" {
  type = string
}
variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
#variable "vpc_security_group_ids" {}


# Auto Scaling
variable "auto_name" {
  type = string
}
variable "max_size" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "asg_health_check_type" {}
variable "target_group_arns" {}
variable "project" {}
variable "health_check_grace_period" {}
variable "vpc_zone_identifier" {
  type = string
}

# scale up policy
variable "scale_up_scaling_adjustment" {}
variable "scale_up_cooldown" {}
variable "scale_up_policy_type" {}

# aws scale up cloudwatch metic alarm
variable "scale_up_alarm_description" {}
variable "scale_up_comparison_operator" {}
variable "scale_up_evaluation_periods" {}
variable "scale_up_metric_name" {}
variable "scale_up_namespace" {}
variable "scale_up_period" {}
variable "scale_up_statistic" {}
variable "scale_up_threshold" {}

# scale down policy
variable "scale_down_scaling_adjustment" {}
variable "scale_down_cooldown" {}
variable "scale_down_policy_type" {}

# aws scale up cloudwatch metic alarm
variable "scale_down_alarm_description" {}
variable "scale_down_comparison_operator" {}
variable "scale_down_evaluation_periods" {}
variable "scale_down_metric_name" {}
variable "scale_down_namespace" {}
variable "scale_down_period" {}
variable "scale_down_statistic" {}
variable "scale_down_threshold" {}
