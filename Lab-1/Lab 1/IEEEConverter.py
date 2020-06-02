def float_bin(number):
	whole, dec = str(number).split('.')


	whole = int(whole)
	dec = int(dec)


	res = bin(whole).lstrip("0b") + "."

	places = 11-(len(res)-1)
	print(places)

	for x in range(places):
		whole,dec = str(float((dec_con(dec)))*2).split(".")
		dec = int(dec)

		res+=whole

	return res

def dec_con(num):
	while num>1:
		num /= 10
	return num

n = input("Enter the Floating Point Number \n")

print(float_bin(n))