# README

Welcome to my chat API 

### Prerequisites

To help in setting the project up and running here are some of the versions I used to develop this api app

RVM - 1.29.10
Ruby - 2.6.2p47
Rails - 6.0.3.4
httpie - 2.3.0 (manually testing APIs) 

### Installing

#### clone the repo

#### install dependencies
```
Bundle install
```
#### run migrations

```
rails db:migrate
```
#### run rails server
```
rails s
```
#### Run Tests
```
bundle exec rspec
```

### Endpoints

## POST /users 
#### creates a chat user
```
$ http POST :3000/users username=yourusername123
```

## GET /users
#### find all the users and returns it in a JSON object
```
$ http GET :3000/users
```
## GET /users/:username
#### find user by username and returns it in a JSON object
```
$ http GET :3000/users/yourusername123
```

## POST /channels 
#### creates a chat channel
```
$ http POST :3000/channels name=yourchannel
```

## GET /channels 
#### find all chat channels
```
$ http GET :3000/channels
```

## GET /channels/:id
#### find chat channel using id and returns it in a JSON object
```
$ http GET :3000/channels/1
```

## POST /channels/:id/channel_messages
#### creates a chat channel messages using channel id and user id (userId should be provided in the body and channel id in endpoint)
```
$ http POST :3000/channels/1/channel_messages message="test message" user_id=1
```

## GET /channels/:id/channel_messages
```
$ http GET :3000/channels/1/channel_messages
```

## PUT and DESTROY methods are available for /channels and /channel_messages 


## Functionality

### A user has to be created using the /users endpoint in order to persist a user chat message
### A channel has to be created using the /channel endpoint in order to persist a user chat message
### In order for 2 or more users to interact a channel ID must be used to create channel messages for different User IDs 

## Back-End challange requirements and coverage

1. As a consumer of the API, I can persist my chat messages 

```
$ http POST :3000/users username=yourusername123
$ http POST :3000/channels name=yourchannel
$ http POST :3000/channels/1/channel_messages message="test message" user_id=1
$ http GET :3000/channels/1/channel_messages

```


2. As a consumer of the API, I can persist messages in specific channels I join. 

```
$ http POST :3000/users username=yourusername123
$ http POST :3000/channels name=yourchannel
$ http POST :3000/channels/1/channel_messages message="test message" user_id=1
$ http GET :3000/channels/1/channel_messages

```

3. As a consumer of the API, I can see the list of all the available channels 

```
$ http GET :3000/channels/

```

4. As a consumer of the API, I can receive gif suggestions - NOT Implemented

5. As a consumer of the API, I can look up other users and channels 

```
$ http GET :3000/channels/
$ http GET :3000/users/

```

6. As a consumer of the API, I can see chat statistics of users and channels

```
$ http GET :3000/channels/
$ http GET :3000/users/

```