from collections import UserList, UserString


print("Hello, world")
x = 4       # x is of type int
x = "Sally" # x is now of type str
print(x)

x = 5
y = "John"
print(type(x))
print(type(y))

x, y, z = "Orange", "Banana", "Cherry"
print(x)
print(y)
print(z)

x = y = z = "Orange"
print(x)
print(y)
print(z)

fruits = ["apple", "banana", "cherry"]
x, y, z = fruits
print(x)
print(y)
print(z)

var1 = x = 5
var2 = y = 2
print(x)
print(y)

var3 = z = x + y
print(z)

Greeting = "Hello"
name = "Aziza!"
print( Greeting, name)

var1 = 7
print("value 1:", var1)

var1 = 99
print("value 2:", var1)

var1 = "You got the point"
print("value 3:", var1)


a = 'int'
b = 7
c = False
d = "18.5"
# I removed the quotation mark so that d is now a float and not an string.
# hashtag are used to add comments in your syntak that will not get excuted :) like these two lines.
d = 18.5
print(type(a), type(b), type(c), type(d))
print(type(a))
print(type(b))
print(type(c))
print(type(d))

x = b + d
print(x)
# Python is fun!



x = 5

for i in range(50):
    # do something here
    print(x * i)


arr = ["Coen", "Casper", "Joshua", "Abdessamad", "Saskia"]

for z in arr:
    print(z) 




import random

for k in range(5):
    print(random.randint(0,100))

    # defining a function, which then takes the value x provided and prints the string with that value in correct spot.

def my_function(F):
      print(" Hello " + F)

F = "world !"
F = "Aziza !"


my_function(F)

def av(x, y):
    	return( (x + y) / 2)
x = 128
y = 255
z = av(x, y)

print("The average of", x, "and", y, "is", z)

Group1 = ["Aziza", "Matais", "Mylene"]
for x in Group1:
    print(x)


L = [1, 5, 1, 3, 7, 9]

for x in range(len(L)):
    if L[x] == L[len(L)-1]:
        print(L[x] + L[0])
    else:
        print(L[x] + L[x + 1])

import csv

Students_dict = {
    "First name: ": "Ann",
    "Last name: ": "Smith",
    "Job title: ":"Student",
    "Company: ": "Techgrounds"
}
# Create key, value pairs to link user input to the dictionary
Students_dict["First name: "] = input("FirstName:")
Students_dict["Last name: "] = input("LastName:")
Students_dict["Job title: " ] = input("jobtitle:" )
Students_dict["Company: " ] = input("company:" )

for key, value in Students_dict.items():
    print(key, value)