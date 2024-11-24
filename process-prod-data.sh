#!/bin/bash

if [ -f .env ]; then
  source .env
else
  echo "Not found .env file"
  exit 1
fi

if ! docker exec -it "$DB_CONTAINER_NAME" [ -d "$PROD_DATA_DIR" ]; then
  echo "Directory for prod-data does not exist in the container. Creating..."
  docker exec "$DB_CONTAINER_NAME" mkdir -p "/$PROD_DATA_DIR"
fi

for file in "$PROD_DATA_DIR"/*; do
  echo "Processing $(basename "$file")"
  docker cp "$file" "$DB_CONTAINER_NAME:$PROD_DATA_DIR/"
  docker exec -i "$DB_CONTAINER_NAME" mysql --default-character-set=utf8mb4 -u root $DATABASE_NAME < "$PROD_DATA_DIR/$(basename "$file")"
done