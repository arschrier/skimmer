# Skimmer

## Getting started

Skimmer is a tool that automates Digital Ocean workflows. 

Skimmer depends on Ruby and Serverless. Before getting started, make sure both are correctly installed on your machine.

```
$ ruby -v && sls -v
```

1. Configure Serverless to use your AWS account

```
$ sls config credentials --provider aws --key <user_key> --secret <user_secret>
```

2. Clone Skimmer into your desired directory

```
$ git clone https://github.com/arschrier/skimmer.git
```

3. Create your Skimmer config file

```
$ touch .config/serverless.yml
```

4. Configure Skimmer to use your Digital Ocean account

```
# add this to your .config/serverless.yml

access_token: <access_token>
skim_snapshots: 
  droplets: <droplet_ids>
```

5. Deploy Skimmer to AWS

```
$ sls deploy
```

## Configuring Skimmer

In addition to plaintext, Skimmer supports a variety of Serverless config variables.

Reference environment variables

```
access_token: ${env:ACCESS_TOKEN}
```

Reference CLI options

```
access_token: ${opt:access_token}
```

Reference CloudFormation outputs

```
access_token: ${cf:some-service-dev.accessToken}
```

Reference S3 objects

```
access_token: ${s3:someBucket/accessToken}
```

Reference SSM parameters

```
access_token: ${ssm:/path/to/some/service/accessToken}
```

It is always a good idea to encrypt your access token and store it somewhere secure. An SSM paramter can be a good way of doing this.

## Supported workflows

- Deleting old snapshots (skimming snapshots)