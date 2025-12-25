# 🧊 iceberg-puddle

For the love of god I don't need an entire lake.

Do you just want to get some development work done? Do you just want to stand up a local Iceberg REST catalog & some S3 compatible object storage? Do you just want to get pyiceberg or spark-iceberg working? Yeah, me too.

⚠️ It should go without saying but **do not use this in production**. Do not put this on the public internet. This is explicitly for local/development usage and there's zero security on anything in here. Don't do it!

## Components

- [Lakekeeper](https://docs.lakekeeper.io/): Iceberg REST catalog
- [PostgreSQL](https://www.postgresql.org/): Persistentence layer for Lakekeeper
- [Garage](https://garagehq.deuxfleurs.fr/): Object storage

## Usage

`docker compose up` or `podman compose up` depending on what flavor of psycho you are.

## TODO

- Nicer configuration
- pyiceberg/spark configuration output

