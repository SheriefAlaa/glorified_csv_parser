# OtpCsvParser

# A programming interview task.

## Model

- We should have two modules `Product` and `Category`. D
- Each product should have multiple categories. D

### Products fields

- name (Arabic) D
- name (English) D
- description (Arabic) D
- description (English) D
- price D
- listed (boolean) D

### Category fields

- name (Arabic) D
- name (English) D

## Requirement

### Genserver that process a csv file

- Creates a new DB record if it was a new. D
- Updated a previous one
- Validates uniqueness of name D
- Validates required information
  - name is required D
  - description is not required D
  - price is required and must be greater than 0 D
  - listed is not required but it has a default value of true D
- Add multiple categories to the product D

### User Expectation

- User should run a GraphQL mutation that generates a process identifier D
- User should send the CSV file using post request using the generated identifier D
- User subscribes to GraphQL subscription for parsing progress (number of failures, number of success, and remaining rows). D
- User can fetch the failure records using graphql (with failure reason). D

### System Behaviour

- User can access the process information for a 1 hour after the process is finished D
- After 1 hour all data should be removed D
- After downloading the failure result, the user should not be able to download it again D
- user is able to process multiple files at the same time and listen for each one. D 

## Remark:
  It's best to generate a process ID for each file. Because each process is responsible for a single file, otherwise, all results will be teated as a single file)