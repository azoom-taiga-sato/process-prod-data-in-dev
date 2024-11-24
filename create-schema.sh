#!/bin/bash

if [ -f .env ]; then
  source .env
else
  echo "Not found .env file"
  exit 1
fi

if ! docker exec -it "$DB_CONTAINER_NAME" [ -d "$SCHEMA_DIR" ]; then
  echo "Schema directory does not exist in the container. Creating..."
  docker exec "$DB_CONTAINER_NAME" mkdir -p "/$SCHEMA_DIR"
fi

for file in "$SCHEMA_DIR"/*; do
  echo "Processing $(basename "$file")"
  docker cp "$file" "$DB_CONTAINER_NAME:$SCHEMA_DIR/"
  docker exec -i "$DB_CONTAINER_NAME" mysql -u root $DATABASE_NAME < "$SCHEMA_DIR/$(basename "$file")"
done