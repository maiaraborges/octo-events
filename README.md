## About the challenge

Octo Events is an application that listens to Github Events via webhooks and expose by an api for later use.

## Events Resource

CRUD implementation of events, available in /events/ resource.

### Events entity

|Field|Type|Description|Rules|Default|
|:---|:--:|:----------|:---:|:-----:|
|`id`|int|ID of a event|unique,   read only|-|
|`action`|str|Action of a event|required|-|
|`number`|int|Number of a event|required|-|
|`created_at`|datetime|Moment when event is created|read only|-|
|`updated_at`|datetime|Moment when event is updated|read only|-|

### Events Actions

|Path|Method|Status Code|Description|
|:---|:----:|:---------:|:----------|
|`/events`|`GET`|200|List all events|
|`/issues/:number/events`|`GET`|200|Get a event object|
|`/events`|`POST`|201|Create a event|

## List all events

**Request:**
> GET /events

**Response:**

> 200 OK
```javascript
[ 
  {"id":11,"action":"edited","number":7,"created_at":"2020-06-17T16:05:36.000Z","updated_at":"2020-06-17T16:05:36.000Z"},
  {"id":12,"action":"edited","number":6,"created_at":"2020-06-17T16:35:21.000Z","updated_at":"2020-06-17T16:35:21.000Z"}
]
```

## Search event by number

**Request:**
> GET /issues/6/events

**Response:**

> 200 OK
```javascript
[ 
  { "action": "edited", created_at: "2020-06-17T16:35:21.000Z"}
]
```

## Create event

**Request:**
> GET /events

**Response:**

> 201 OK
```javascript
  {"id":11,"action":"edited","number":7,"created_at":"2020-06-17T16:05:36.000Z","updated_at":"2020-06-17T16:05:36.000Z"}
```

## Testing specification

- **`should be able to create a new event`**: application must allow a event to be created and return a json with the created project.

- **`should be able to list the event`**: application must allow a event to be created and return a json with the created project.

- **`should be able to find events by number`**: application should allow searches with events number and return a json.

- **`should be able generate errors when trying to search for an unregistered events by number`**: application should not allow searches with number of events that do not exist.

## Local use

* Install the gem

```sh
bundle install
```

* Creating the database

```sh
rails db:create
```

* Running the migrations

```sh
rails db:migrate
```

* Upload application

```sh
rails s
```

* Run the tests

```sh
rspec spec
```

## Config ngrok and Webhooks

* Install ngrok (https://ngrok.com/)

* Start a HTTP tunnel forwarding to your local port 3000

```sh
$ sudo ngrok http 3000 
```

* Configure Webhooks in the repository

![alt text](imgs/confing_webhooks.png)

## Gem used

* gem 'github_webhook'
* gem 'rspec-rails'
* gem 'dotenv-rails'