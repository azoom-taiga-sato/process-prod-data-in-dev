# Process Prod Data in Local Development
A repository to process data from production database (mysql) in development environment

## Background in Creation of this Repository
Theare are some cases that we need to process prod data in development environment.

e.g.)
- Extract target user data from table in production database by executing SQL several times (Since SQL to ectract data in one go is not supported by the sql version in use)
- Set the extracted data in another table and check validity of the data with designated conditions (Creating another table with the extracted data in production database is not recommended)

## Actual Use Case

### Tomemiru Webinar Advertisement Email Bulk Sending
Marketing department asks IT department to send builk email about Tomemiru webinar advertisement to large number of users via Sendgrid marketing campaing feature.
Target user data is extracted from `ps_contact_log` in production `parking` database.


## How to Use

1. Share `SELECT` sql sentence to extract target user data with Ishi-san. Then, ask him to extract user data from production db and share `INSERT` sql with the member in charge.

2. Download and open the zipped file with the password (Ishi-san will delete the file and password immediately)

3. Move the sql file to `prod-data/*`.

4. Set schema files for target table in `schema/*`.

5. Install dependencies
```bash
pnpm install
```
6. Create docker container
```bach
pnpm dcc up -d
```

7. Create schema for target tables
```bach
pnpm create-schema
```

8. Process (CRUD) prod data in development environment
```bash
pnpm process-prod-data
```