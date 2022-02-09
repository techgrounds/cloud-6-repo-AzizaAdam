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