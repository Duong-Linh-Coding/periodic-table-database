#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
if [[ ! $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_PROPERTY_INFO=$($PSQL "SELECT atomic_number, symbol, name, typee, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol='$1' or name='$1'")
else
  ELEMENT_PROPERTY_INFO=$($PSQL "SELECT atomic_number, symbol, name, typee, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number=$1")
fi  


    if [[ -z $ELEMENT_PROPERTY_INFO ]]
    then
      echo "I could not find that element in the database."
    else
    echo $ELEMENT_PROPERTY_INFO | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR
      do
      if [[ $ATOMIC_NUMBER != atomic_number ]]
      then
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      fi
    done
  fi
fi
