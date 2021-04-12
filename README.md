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

###Simo feedback
Documentation
- Nice README. It’s good to see details of your reasoning and design.
- You’re missing instructions on how to install - wouldn’t they have to run bundle?
- Your usage example could be more detailed (e.g. show how the Bank class is supposed to be used.)
- It would also be nice to see your test coverage stats mentioned!
Edge cases:
- Nice handling of the invalid amount edge case! Would be good to mention in your README that you decided to do this and why, since is wasn’t part of the original problem statement.
Object-oriented design
- It was a good design decision to separate your printing and formatting responsibilities and your deposit/withdrawal code into different classes.
- However, I think your Printer class could be combined with the Processor class (it could be called StatementPrinter maybe), since the Printer class relies on the fact that the Processor returns the same number of columns as the Printer is printing in the header. So they are tightly coupled, which might indicate that they are sharing responsibilities instead of having separate responsibilities.
- You had some trouble connecting the classes. You might want to look into forwarding and dependency injection for a hint of how you can connect Bank.print_statement to your Printer and Processor classes. https://github.com/makersacademy/skills-workshops/blob/master/practicals/object_oriented_design/oo_relationships.md#forwarding, https://github.com/makersacademy/skills-workshops/blob/master/practicals/object_oriented_design/dependency_injection.md#introduction
- You shouldn’t need to store the balance separately in Bank. It duplicates state since you’re already storing balances in each of the transactions in @history. How could you make use of that to return a balance without storing it separately in its own insance variable?
- Nice use of keyword arguments in your record_transaction function - makes it easier to follow what the different parameters are
- In Printer#print, is file really the best name for this parameter?
- I like the way you’ve split up all your formatting code into short functions in Processor, makes things very readable and DRY
- Do you really need to pass in destination_str as a parameter to format_transactions?
Testing
- Nice use of stubbing for dates!
- Good testing of edge cases
- Tests like “responds to a X method” are redundant once you have other tests that actually exercise those methods or the constructor.
- Testing the contents of the history of transactions is testing state rather than behaviour. The history is an implementation detail of the Account class and shouldn’t be publicly accessible from outside the class. The account.print_statement class is the best to test the output of that method (behaviour) rather than look at the list of transaction itself (state). So once you have that connected up, it should make testing easier as well. Also see https://github.com/makersacademy/skills-workshops/blob/master/practicals/testing/behaviour_not_state.md
- You shouldn’t be using your Bank class in your unit tests for Printer or Processor because it means they are not isolated anymore. You can make up fake test data instead (i.e. fake arrays simulating a transaction history).
- I’m not sure orders transactions by date, descending is the strongest test since both transactions have the same date
- I think that once you combine your Printer and Processor functionality, you might find the resulting class easier to test as you can just test the result of printing all at once.
- You’re missing a feature test that demonstrates that the acceptance criteria are met. It’s good to use exactly the same example as in the original problem statement to make sure and demonstrate that your output matches it.
