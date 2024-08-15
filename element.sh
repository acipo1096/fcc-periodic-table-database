#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

GET_ELEMENT_INFO() {

  # if permitting, should i do while loop so it keeps running until correctly executed?
  if [[ ! $1 ]]
  then
    # error message stating that no argument exists
    echo "Please provide an element as an argument."
  else
    # use argument as the base to find the other information
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      # get atomic number
      ATOMIC_NUMBER=$($PSQL "SELECT name,symbol FROM elements WHERE atomic_number=$1;")
    else
       # get symbol
       if 
       then
       else
        # get name
        if 
        then 
        else
        fi
    fi
    echo $ATOMIC_NUMBER
  fi
}

GET_ELEMENT_INFO $1