import boto3
import logging
from os import environ

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
LOCALSTACK_HOSTNAME = environ['LOCALSTACK_HOSTNAME']
# Initialize the EC2 instance and SNS clients
ec2 = boto3.client('ec2', region_name=environ['AWS_REGION']) #define AWS_REGION to actual region in environment variable
sns = boto3.client('sns', region_name=environ['AWS_REGION'])

def lambda_handler(event, context):
    instance_id = environ['INSTANCE_ID']

    try:
        response = ec2.reboot_instances(InstanceIds=[instance_id])
        logger.info(f"Restarted EC2 instance: {instance_id}")

        # Publish message to SNS topic
        sns.publish(
            TopicARN=environ['SNS_TOPIC_ARN'],
            Message=f"EC2 instance {instance_id} has been restarted.",
            Subject='EC2 Instance Restart Notification'
        )

    except Exception as e:
        logger.error(f"We could not restart your EC2 instance: {str(e)}")
        raise e
    return {
        'statusCode': 200,
        'body': f"Your EC2 instance with {instance_id} restarted successfully and pinged you"
    }
