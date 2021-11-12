output "notifications_sns_topic_arn" {
  value = aws_sns_topic.notify-topic.arn
  description = "ARN of SNS topic where CodePipeline and CodeBuild notifications are sent"
}
