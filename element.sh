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
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
      # set other variables
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1;")
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1;")
    else
      # get symbol
      if [[ $1 =~ ^[A-Z][a-z]?$ ]]
      then
        # get symbol
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1';")
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
        NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1';")
      else
        if [[ $1 =~ ^[A-Z][a-z]+$ ]]
        then
          # get name
          NAME=$($PSQL "SELECT name FROM elements WHERE name='$1';")
          SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1';")
          ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
        fi
      fi
    fi
    if [[ $ATOMIC_NUMBER != "" || $SYMBOL != "" || $NAME != "" ]]
    then
      # get appropriate info from properties and type
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER;")
      TYPE=$($PSQL "SELECT type FROM properties LEFT JOIN types ON properties.type_id = types.type_id WHERE atomic_number=$ATOMIC_NUMBER;")
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    else
      echo "I could not find that element in the database."
    fi
  fi
}

GET_ELEMENT_INFO $1