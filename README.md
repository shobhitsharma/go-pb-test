# go-pb-test

Testing grpc/protobuf using go modules

## Development

```bash
$ make build

# tcp :4040
$ cd server && go run main.go

# tcp :8080
$ cd client && go run main.go
```