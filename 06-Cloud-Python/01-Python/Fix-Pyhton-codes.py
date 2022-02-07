#1
foo = 'hello'
ls = ['Casper', 'Floris', 'Esther']
for name in ls:
	print(foo,name)

#2
foo = 20
bar = 80
print(foo + bar)

#3
foo = 20
for i in range(10):
	foo += 1

print(foo)

#4
foo = 0
while foo < 5:
	print('there are', foo, 'kids on the street')
	foo += 1

#5
ls = ['Lord of the rings', 'Star Trek', 'Iron Man', 'Star Wars']
print(ls[3])

#6
foo = 80
if foo < 30:
	print(foo)
elif foo < 100:
	print(foo)

#6
foo = 80
if foo < 30:
	print(foo)
elif foo < 100:
	print(foo)
else:
    print('big number wow')

#7
ln = ['Dog', 'Cat', 'Elephant', 'Fly', 'Horse']
short_names = []

for animal in ln:
	if len(animal) == 3:
		short_names.append(animal)

print(short_names)


#8
foo = 10
bar = 2
print(foo*bar)

#9
for i in range(10):
    if i < 10:
        print(i)

#10
print('the number is ' + "20")


#11
dev_monster = "IT LIVES!"
print(dev_monster)


#12
def square(x):
    	return x**2

nr = square(2)
print(nr)
foo = 127
big = square(foo)
print(big)


#13
import random

x= random.randint(1,100)
print(x)

#14
def rtn(x):
    	return(x)

foo = rtn(3)

if foo < rtn(4):
	print(True)
else:
	print(False)

#15
foo = ''
for i in range(3):
	foo += 'a'
    for j in range(3):
            foo += '5'
            for k in range(3):
	            foo += '|'

print(foo)


#16
import random

# generate random int
goal = random.randint(1,100)

win = False
tries = 0

while win == False and tries < 7:
	try:
		# ask for input
		inpt = int(input("Please input a number between 1 and 100: "))
		# count attempt as a try
		tries += 1

		# check for match
		if inpt == goal:
			win = True
			print("Congrats, you guessed the number!")
			print("It took you", tries, "tries")
		# give hints
		elif inpt < goal:
			print("The number should be higher")
		else:
			print("The number should be lower")

	except:
		print("Please type an integer")

# 
if win == False:
	print("Game over! You took more than seven tries")
	

