
# Script to send SNS alerts to Slack.
#!/usr/bin/python3.6
import urllib3
import json
http = urllib3.PoolManager()
def lambda_handler(event, context):
    url = "<<SLACK_WEB_HOOK>>"
    msg = {
        "channel": "#aws-alerts",
        "username": "AWS Account Alerts",
        "text": event['Records'][0]['Sns']['Message'],
        "icon_emoji": ":aws:"
    }
    
    encoded_msg = json.dumps(msg).encode('utf-8')
    resp = http.request('POST',url, body=encoded_msg)
    print({
        "message": event['Records'][0]['Sns']['Message'], 
        "status_code": resp.status, 
        "response": resp.data
    })
