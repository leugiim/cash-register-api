# Technical Challenge by Miguel Rodríguez

This application is a cash register where the user can create products and discounts. Given a list of products, the app generates a ticket detailing the items bought and any applied discounts. It serves as a handy tool for managing sales transactions.

## Related

- The frontend repository is: [https://github.com/leugiim/cash-register-app](https://github.com/leugiim/cash-register-app)
- The api documentation is: [http://localhost:3000/api-docs](http://localhost:3000/api-docs)

## Requirements

- Ruby version: 3.2.2
- Rails version: 7.1.3
- Sqlite3 version: 3.43.2

## How to run the server

**Bundle Install:** Execute the following command to download all dependencies:

```bash
bundle install
```

**Start Rails Server:** Use the following command to run the server:

```bash
rails server
```

## How to initialize the database

**Migrate Tables:** Execute the following command to create necessary tables:

```bash
rails db:migrate
```

**Seed Data:** Initialize the database with test data using the following command:

```bash
rails db:seed
```

## How to run the test suite

**Running Tests:** To run tests, execute the following command:

```bash
rspec --force-color --format documentation
```

## Description

**Products Registered**
| Product Code | Name | Price |  
|--|--|--|
| GR1 | Green Tea | 3.11€ |
| SR1 | Strawberries | 5.00 € |
| CF1 | Coffee | 11.23 € |

**Special conditions**

- The CEO is a big fan of buy-one-get-one-free offers and green tea.
  He wants us to add a rule to do this.

- The COO, though, likes low prices and wants people buying strawberries to get a price discount for bulk purchases.
  If you buy 3 or more strawberries, the price should drop to 4.50€.

- The VP of Engineering is a coffee addict.
  If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.

Our check-out can scan items in any order, and because the CEO and COO change their minds often, it needs to be flexible regarding our pricing rules.

**Test data**
| Basket | Total price expected |  
|--|--|
| GR1,GR1 | 3.11€ |
| SR1,SR1,GR1,SR1 | 13.61€ |
| GR1,CF1,SR1,CF1,CF1 | 30.57€ |
