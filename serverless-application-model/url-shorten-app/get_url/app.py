import boto3
import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# This function will get original URL from shorten URL then return to the user
def lambda_handler(event, context):
    logger.info('Event structure: ' + json.dumps(event))  # Log the event structure

    short_url = event['pathParameters']['short_url']

    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('UrlShortenTable')

    response = table.get_item(
        Key={
            'short_url': short_url
        }
    )

    if 'Item' in response:
        return {
            'statusCode': 308,
            'headers': {
                'Access-Control-Allow-Origin': '*',  # Allow requests from any origin
                'Access-Control-Allow-Headers': 'Content-Type, Authorization',  # Allow the Content-Type header
                'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',  # Allow OPTIONS and POST methods
                'Location': response['Item']['original_url']
            },
            'body': json.dumps({'status': 'redirecting', 'url': response['Item']['original_url']})
        }
    else:
        return {
            'statusCode': 404,
            'body': json.dumps({'status': 'error', 'message': 'URL not found'})
        }
