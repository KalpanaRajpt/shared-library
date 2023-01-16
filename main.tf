provider "aws" {
  region = "us-east-1"
}


resource "aws_launch_template" "this" {
  name_prefix   = var.name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
}
#####################################
resource "aws_autoscaling_group" "this" {

  name                      = var.auto_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  #health_check_type         = var.asg_health_check_type #"ELB" or default EC2
  #availability_zones = var.availability_zones #["us-east-1a"]
  vpc_zone_identifier = [var.vpc_zone_identifier]
  #target_group_arns   = [module.aws_lb.lb_tg_arn] #var.target_group_arns

  
    launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version #"$Latest"
  }
  }

# scale up policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.project}-asg-scale-up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_up_scaling_adjustment #increasing instance by 1 
  cooldown               = var.scale_up_cooldown
  policy_type            = var.scale_up_policy_type
}
##################3
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "${var.project}-asg-scale-up-alarm"
  alarm_description   = var.scale_up_alarm_description
  comparison_operator = var.scale_up_comparison_operator
  evaluation_periods  = var.scale_up_evaluation_periods
  metric_name         = var.scale_up_metric_name
  namespace           = var.scale_up_namespace
  period              = var.scale_up_period
  statistic           = var.scale_up_statistic
  threshold           = var.scale_up_threshold # New instance will be created once CPU utilization is higher than 30 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}
############################################################
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.project}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_down_scaling_adjustment 
  cooldown               = var.scale_down_cooldown
  policy_type            = var.scale_down_policy_type
}
##########################
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "${var.project}-asg-scale-down-alarm"
  alarm_description   = var.scale_down_alarm_description
  comparison_operator = var.scale_down_comparison_operator
  evaluation_periods  = var.scale_down_evaluation_periods
  metric_name         = var.scale_down_metric_name
  namespace           = var.scale_down_namespace
  period              = var.scale_down_period
  statistic           = var.scale_down_statistic
  threshold           = var.scale_down_threshold # Instance will scale down when CPU utilization is lower than 5 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}

