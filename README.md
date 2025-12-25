# iceberg-puddle

For the love of god I don't need an entire lake.

Do you just want to get some development work done? Do you just want to stand up a local Iceberg REST catalog & some S3 compatible object storage? Yeah, me too.

## Components

- [Lakekeeper](https://docs.lakekeeper.io/): Iceberg REST catalog
- [PostgreSQL](https://www.postgresql.org/): Persistentence layer for Lakekeeper
- [Garage](https://garagehq.deuxfleurs.fr/): Object storage

## Usage

`docker compose up` or `podman compose up` depending on what flavor of psycho you are.

## TODO

- Is there a way to make Garage shut up? Log-spamming every single GetClusterStatus/GetClusterLayout API request from the health check seems not ideal.

