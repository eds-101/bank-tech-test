Bank Tech Test
=================

## Edeman George
* My solution uses two classes:
* A Bank class for completing and storing transactions, and a StatementPrinter to process and print the bank account statements
* It runs through IRB, with instructions below
* Test coverage == 100%


# Design decisions
* I used three classes to separate responsibilities, although I reverted to using two because the Statement and Printer classes were still tightly coupled
* I used a dependency injection for the Bank's print_statement method, in order to preserve flexibility in the code
* I added guards for the Bank's deposit and withdraw methods in order to make sure input was a number, so the input could be controlled and avoid accidental bugs.

* How to install and run the program:
```sh
$ git clone git@github.com:makersacademy/bank-tech-test.git
Use your terminal, navigate to root of this project root folder and run the following commands
$ cd lib
$ bundle
$ irb
$ require "./bank.rb"
$ bank = Bank.new
$ bank.deposit(1000)
$ bank.withdraw(50)
$ bank.print_statement
```
* How to run tests:
```sh
Use your terminal and navigate to root of this project root folder
$ rspec
```

* How to pass the acceptance criteria:
```sh
Run `rspec` from the command line to see the passing feature test
See spec/features/acceptance_spec.rb specifically for the acceptance test hardcoded
```

## Specification

### Requirements

* You should be able to interact with your code via a REPL like IRB or the JavaScript console.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```
