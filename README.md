# Rock-Paper-Scissors API
---
API that allows a user to play rock-paper-scissors.

## Overview
---
This application uses Rails version 5.2.6, Ruby version 2.3.5.

## Local setup
---
* Install Ruby version 2.3.5: `rvm install 2.3.5`
* Bundle: `bundle install`
* Run specs: `bundle exec rspec`
* Run server: `rails server`

## How to play
---
* To get list of possible choices: `curl localhost:3000/choices`
* To play the game: `curl -X GET -d choice={your_choice} localhost:3000/get-result`
* If you win you will get a message which says: `You won! Curb with {curb_choice} loses.`
* If you lose you will get a message which says: `You lost! Curb with {curb_choice} wins.`
* If draw: `Draw! Curb also chose {curb_choice}.`

## Rules
---
* Rock beats scissors
* Scissors beats paper
* Paper beats rock
* Identical throws tie (rock == rock, etc.)
