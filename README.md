# Simple AWS CloudFormation Template

Simple AWS CloudFormation Template for proof of concept/non-production use

## Quick and dirty start up
1. Clone this repo

2. Modify params to suit
```
$ grep ParamVpcStackName params/launch-web.json 
  { "ParameterKey": "ParamVpcStackName",      "ParameterValue": "simple-web-v11" },
```

3. Ensure [AWS CLI is installed and configured](https://amzn.to/32lyWRl)

4. Deploy the template
```
./launch-web.sh <aws profile>
```
