#!/bin/bash

# Function to calculate factorial
factorial() {
  local n=$1
  local result=1
  while [ $n -gt 1 ]; do
    result=$((result * n))
    n=$((n - 1))
  done
  echo $result
}

# Ask for calculation operand
echo "Input calculation operand (+, -, *, /, %, !):"
read operand

# Perform operations based on the operand
case $operand in
  +|-|\*|/|%)
    echo "Input number1:"
    read number1
    echo "Input number2:"
    read number2
    
    # Perform the calculation
    case $operand in
      +) result=$((number1 + number2)) ;;
      -) result=$((number1 - number2)) ;;
      \*) result=$((number1 * number2)) ;;
      /) 
        if [ $number2 -eq 0 ]; then
          echo "Error: Division by zero!"
          exit 1
        else
          result=$((number1 / number2))
        fi
        ;;
      %) 
        if [ $number2 -eq 0 ]; then
          echo "Error: Division by zero!"
          exit 1
        else
          result=$((number1 % number2))
        fi
        ;;
    esac
    ;;
  !)
    echo "Input number:"
    read number
    
    # Perform the factorial calculation
    if [ $number -lt 0 ]; then
      echo "Error: Negative number for factorial!"
      exit 1
    else
      result=$(factorial $number)
    fi
    ;;
  *)
    echo "Error: Invalid operand!"
    exit 1
    ;;
esac

# Print the result
echo "Result: $result"
