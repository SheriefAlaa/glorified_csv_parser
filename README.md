# OtpCsvParser

# A programming interview task.

## Model

- We should have two modules `Product` and `Category`.
- Each product should have multiple categories.

### Products fields

- name (Arabic)
- name (English)
- description (Arabic)
- description (English)
- price
- listed (boolean)

### Category fields

- name (Arabic)
- name (English)

## Requirement

### Genserver that process a csv file

- Creates a new DB record if it was a new.
- Updated a previous one
- Validates uniqueness of name
- Validates required information
  - name is required
  - description is not required
  - price is required and must be greater than 0
  - listed is not required but it has a default value of true
- Add multiple categories to the product

### User Expectation

- User should run a GraphQL mutation that generates a process identifier
- User should send the CSV file using post request using the generated identifier
- User subscribes to GraphQL subscription for parsing progress (number of failures, number of success, and remaining rows).
- User can fetch the failure records using graphql (with failure reason).

### System Behaviour

- User can access the process information for a 1 hour after the process is finished
- After 1 hour all data should be removed
- After downloading the failure result, the used should not be able to download it aging
- user is able to process multiple files at the same time and listen for each one.