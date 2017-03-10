# techtest-tic-tac-toe
Tech test from Makers Academy - modelling a two player game of Tic Tac Toe

## The brief

The rules of tic-tac-toe are as follows:

- [x] There are two players in the game (X and O)
- [x] Players take turns until the game is over
- [x] A player can claim a field if it is not already taken
- [x] A turn ends when a player claims a field
- [x] A player wins if they claim all the fields in a row, column or diagonal
- [x] A game is over if a player wins
- [x] A game is over when all fields are taken

Build the business logic for a game of tic tac toe. It should be easy to implement a working game of tic tac toe by combining your code with any user interface, whether web or command line.

## Installation and running

The game is built in Ruby with RSpec testing framework. You'll need `ruby` and `bundler` to be installed on your machine. Download the repo to your machine, run `bundle install`, then run `irb`, and require the various files in the `lib` folder to add the game's classes. Alternatively, require the classes into your own application to provide the game logic for your own interface.

## Development notes

The game was developed using a TDD approach. As the spec does not require a UI, feature testing is carried out using RSpec but *not* Capybara. Feature tests are therefore on correct functioning of test cases across the entire game through code, rather than correct functioning of the entire game through an interface. Additionally, some tests are created as feature tests in anticipation of classes being extracted out of the existing codebase, when they could in theory be created as unit tests and moved across when the classes start to get extracted out.

The development priorities and completion status are:

- [x] Initial setup and feature test
- [x] Decide on representation of the game board
- [x] Creation of working tic tac toe
- [ ] Refactoring the game into a cleaner structure
- [ ] Extra functionality

In terms of representation, there are some physical characteristics of the game that are useful to enforce in the structure of the model. Specifically, each field in the board occupies a unique position in physical space, the fields form a complete grid of (usually) 3 across and down and no more, and each field can only be empty, O or X. The #board method should return a representation of the board that's complete enough for a UI or command line user to understand which fields are which, and whether each of them is blank, X or O. Initially, an array with a subarray for each row appears sensible.
