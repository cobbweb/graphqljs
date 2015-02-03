build:
	pegjs graphql.pegjs graphql-parser.js
	node graphql.js

.PHONY: build