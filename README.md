Bank Tech Test
=================

## Edeman George
* My solution uses three classes Bank, Processor and Printer
* Runs via IRB, with instructions below
* It functions and can print output as per requirements.
* It is largely tested - some work outstanding on the print I believe
* I have left the unfunctioning tests for review

# Design decisions
* I used three classes to separate responsibilities, although this was a late decision.
* I unintentionally do not have a bank.print_statement due to separating classes
* It requires manual use of Processor to format the bank.history method, before it can be printed out. (see `How to run the program`)

# Next steps
* Complete testing for all classes
* Work out how to automate processing of bank statement i.e. help classes speak to each other automatically
* Testing - I'm not sure how I can test just one thing for many tests - tbc

* How to run the program:
```sh
$ git clone git@github.com:makersacademy/bank-tech-test.git
Use your terminal and navigate to root of this project root folder
$ cd lib
$ irb
$ require "./bank.rb"
$ require "./processor.rb"
$ require "./printer.rb"
Initialize class instances to use the program features
```
* How to pass the acceptance criteria:
```sh
Use the Bank class to make some deposits and withdrawals
$ processor = Processor.new
$ processed_history = processor.process(bank.history)
$ printer = Print.new
$ printer.print(processed_history)
```

* How to run tests:
```sh
Use your terminal and navigate to root of this project root folder
$ rspec
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