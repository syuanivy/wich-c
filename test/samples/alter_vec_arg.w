func bar(x:[]) {
	x[1] = 100
	print(x) // [100,2,3]
}

var x = [1,2,3]
bar(x)
x[1] = 99
print(x) // [99,2,3]
