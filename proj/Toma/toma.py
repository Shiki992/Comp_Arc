import sys


instructions_total = ["LD", "MUL", "SUB", "ST", "ADD"]

instfile = "instruct/instructions.txt"

instructions = []

stations = [[], [], [], [], [], [], []]  

operations = ["LD","MUL", "SUB","ST","ADD"]

instruction_state = []

# Initializing registers
registers = {'F0': 0, 'F1': 1, 'F2': 2,'F3': 3, 'F4': 4, 'F5': 5,'F6': 6, 'F7': 7, 'F8': 8, 'F9': 9,
             'R0': 0, 'R1': 1, 'R2': 2,'R3': 3, 'R4': 4, 'R5': 5,'R6': 6, 'R7': 7, 'R8': 8, 'R9': 9,
             'G0': 0, 'G1': 1, 'G2': 2,'G3': 3, 'G4': 4, 'G5': 5,'G6': 6, 'G7': 7, 'G8': 8, 'G9': 9}

memory = []

i = 0
while(i<50):
    memory.append(i)
    i += 1



def extract_operands(line, i):
    line = line.split(" ")
    line[-1] = line[-1].replace("\n","")
    return line


# Parsing in tuples and list of instructions
with open(instfile) as file:
    i = 0
    for l in file:
        instructions.append(extract_operands(l, i))
        i += 1



# Iterate over stations to fill them
i = 0
while(i<len(stations)):
    if(i >= len(instructions)):
        break
    station = []
    station.append(instructions[i][0])    # Name
    station.append(1)                      # Busy
    station.append(instructions[i][0])    # OP
    
    if(instructions[i][0] == "LD" or instructions[i][0] == "ST"):
        station.append( instructions[i][1] )    # Vj
        station.append(int(instructions[i][2]) + registers[ str(instructions[i][3]) ])       # Vk
    else:
        station.append( instructions[i][2] )    # Vj
        station.append(instructions[i][3] )     # Vk

    station.append(0)
    stations[i] = station                # Push station
    i += 1



# Enumeration of repeated instructions
i = 0
j = 0
k = 0
while(i<len(instructions)):
    instru = instructions[i]   # extract the instruction to compare it with the others
    
    # Internal iteration
    while(j<len(instructions)):
        
        if(instructions[j][0] == instru[0]):       # Name comparison
            stations[j][-1] = instru[0] + str(k)

            k += 1
        j += 1

    j = 0
    k = 0
    i += 1




# Name setting
i = 0
while(i<len(instructions)):
    stations[i][0] = stations[i].pop()
    i += 1



matrix_oper_results = []
# Saved operators result
i = 00
while(i<len(instructions)):
    operand = instructions[i][1] 
    name = stations[i][0]
    val = []
    val.append(name)
    val.append(operand)
    matrix_oper_results.append(val)
    i += 1
    



# Hazard detection 1
i = 0
j = 0
while(i<len(instructions)):
    instru = instructions[i]
    station = stations[i]
        
    # Internal iteration
    while(j<len(instructions)):
        #print(instru, instructions[j])
        if(instru != instructions[j]):     # If the instruction is the same, not evaluating it

            if(instru[1] == instructions[j][2]):         # Compare result with first operand Qj
                # There is Hazard
                stations[j].append(station[0])
                
        j += 1
    j = 0
    i += 1


# Insertion of 0 if the condition is not met
i = 0
while(i<len(stations)):
    if(len(stations[i]) == 5):
        stations[i].append(0)
    elif(len(stations[i]) > 6):
        stations[i].pop()
    i += 1





# # Hazard detection 2
i = 0
j = 0

while(i<len(instructions)):
    instru = instructions[i]
    station = stations[i]
    
    while(j<len(instructions)):
        if(instru != instructions[j]):     # If the Instruction I am evaluating is not the same
            
            if(instru[1] == instructions[j][3]):         # Compare result with result Qk 
                # There is Hazard
                stations[j].append(station[0])
        j += 1
    j = 0
    i += 1


# # Insertion of 0 if the condition is not met
i = 0
while(i<len(stations)):
    if(len(stations[i]) == 6):
        stations[i].append(0)
    elif(len(stations[i]) > 7):
        stations[i].pop()
    i += 1




# Hazard detection 3
i = 0
j = 0

while(i<len(instructions)):
    instru = instructions[i]
    station = stations[i]
    

    while(j<len(instructions)):
        if(instru != instructions[j]):     # If the Instruction I am evaluating is not the same
            
            if(instru[1] == instructions[j][1]):         # Compare result with result Rout
                # There is Hazard
                stations[j].append(station[0])
        j += 1
    j = 0
    i += 1






# # Insertion of 0 if the condition is not met
i = 0
while(i<len(stations)):
    if(len(stations[i]) == 7):
        stations[i].append(0)
    elif(len(stations[i]) > 8):
        stations[i].pop()
    i += 1



# # Add index for operation
i = 0
while(i<len(stations)):
    if(stations[i][2] in operations):
        if(stations[i][2] == "LD"):
            stations[i].append(5)
        elif(stations[i][2] == "MUL"):
            stations[i].append(3)
        elif(stations[i][2] == "SUB"):
            stations[i].append(2)
        elif(stations[i][2] == "ST"):
            stations[i].append(4)
        elif(stations[i][2] == "ADD"):
            stations[i].append(1)
        else:
            print("Error")
    i += 1




# Hazard Flag
i = 0
while(i<len(stations)):
    if((stations[i][4] and stations[i][5] and stations[i][6]) == 0):
        stations[i].append(0)
    else:
        stations[i].append(1)
    i += 1


# Fill instruction status
i = 0
while(i<len(stations)):
    val = []
    val.append(stations[i][0])
    instruction_state.append(val)
    i += 1



# Change status from instructions to Issue
i = 0
while(i < 7):
    instruction_state[i].append("Issue")
    i += 1



# Include 0 to all states
i = 0
while(i < len(instruction_state)):
    instruction_state[i].append(0)
    i += 1






# Pass the instructions without risk to out
i = 0
while(i < 7):
    if(stations[i][9] == 0):
        instruction_state[i][1] = "out"   
    i += 1




def checkFinished():
    j = 0
    flag = False
    while(j < len(instruction_state)):
        if(instruction_state[j][2] == 1 and len(fin) == len(instruction_state)):
            flag = True
        else:
            flag = False
        j += 1
    
    if(flag == True):
        return True
    else:
        return False


def getInstruction(id):
    i = 0
    while(i < len(instructions)):
        if(instructions[i][0] == id):
            return instructions[i]
        i += 1
    return -1           # Not found
    


def noout():
    n = 0
    flag = False
    #print(instruction_state)
    while(n<len(instruction_state)):
        if(instruction_state[n][1] == "out"):
            flag = True
        n += 1
    
    if(flag == True):
        return True
    else:
        return False

temp = []         
fin = []         # List containing the name of the instructions that have already been executed



def updateInstruction_state():

    k = 0
    while(k < len(instruction_state)):
        if(instruction_state[k][2] == 0):              # If the instruction has not yet been executed
            Instruction_name = instruction_state[k][0]           # Name with which I search the stations to check if I resolved the dependency
            l = 0
            while(l < len(stations)):
                
                if(Instruction_name == stations[l][0]):     # When I find the instruction

                    # If all the dependencies are contained in the end list it means I can pass it out
                    if( (stations[l][5] in fin or stations[l][5] == 0) and (stations[l][6] in fin or stations[l][6] == 0) and (stations[l][7] in fin or stations[l][7] == 0) ):   

                        instruction_state[k][1] = "out"
                        instruction_state[k][2] = 1


                l += 1

        k += 1

print("\n")
print("Status of the stations")
# print("[PATH, BUSY, INSTRUCTIONAL TYPE, Vj, Vk, WAR Dependency with operand 1, WAR Dependency with operand 2, WAW Dependency, Function Code, Dependency Flag]")
k = 0
while(k < len(stations)):
    print(stations[k])
    k += 1

print("\n")
print("Printing the flow between Issue, out and Write of the instructions")
k = 0
while(k < len(instruction_state)):
    print(instruction_state[k])
    k += 1

while(checkFinished() == False):

    if(noout() == False):                # If I no longer have instructions in out

        print("\n")
        k = 0
        while(k < len(instruction_state)):
            print(instruction_state[k])
            k += 1


        updateInstruction_state()


        print("\n")
        k = 0
        while(k < len(instruction_state)):
            print(instruction_state[k])
            k += 1

    
    # Filling process from temp in out
    i = 0
    while(i < len(instruction_state)):
        #print(stations[i], instruction_state[i])
        if(instruction_state[i][1] == "out" and stations[i][-2] == 1):      # Add 
            val = []
            val.append(stations[i][0])
            val.append( int(registers[stations[i][3]])  + int(registers[stations[i][4]]) ) 
            val.append(stations[i][-2])

            temp.append(val)

        elif(instruction_state[i][1] == "out" and stations[i][-2] == 2):     # Sub
            #print(instruction_state[i])
            #print(stations[i])

            val = []
            val.append(stations[i][0])
            res = int(registers[stations[i][3]]) - int(registers[stations[i][4]])

            #print(res, registers[stations[i][3]], registers[stations[i][4]])
            val.append( res )   
            val.append(stations[i][-2])

            temp.append(val)

        elif(instruction_state[i][1] == "out" and stations[i][-2] == 3):     # Mul
            #print(instruction_state[i])
            #print(stations[i])

            val = []
            val.append(stations[i][0])
            res = int(registers[stations[i][3]]) * int(registers[stations[i][4]])

            #print(res, registers[stations[i][3]], registers[stations[i][4]])
            val.append( res )   
            val.append(stations[i][-2])

            temp.append(val)

        elif(instruction_state[i][1] == "out" and stations[i][-2] == 4):     # STORE

            val = []
            val.append(stations[i][0])
            val.append( int(instructions[i][2]) + registers[str(instructions[i][3])] )  # (0 + Valor R1)
            val.append(stations[i][-2])

            temp.append(val)

        elif(instruction_state[i][1] == "out" and stations[i][-2] == 5):     # LOAD  

            val = []
            val.append(stations[i][0])
            val.append( int(instructions[i][2]) + registers[str(instructions[i][3])] )  # (0 + Valor R1)
            val.append(stations[i][-2])

            temp.append(val)
      

        i += 1

    i = 0
    while(i < len(instruction_state)):
        
        if(instruction_state[i][1] == "out"):
            instruction_state[i][1] = "Write"
        i += 1


    #print(temp)

    i = 0
    while(i < len(temp)):
        
        res = []

        Instruction = temp[i][0]
        result = temp[i][1]
        operation = temp[i][2]
        result_operator_name = -1

        

        n = 0
        while(n<len(matrix_oper_results)):
            if(matrix_oper_results[n][0] == Instruction):
                result_operator_name = matrix_oper_results[n][1]
                break
            n += 1

        
        if(result_operator_name == -1):
            print("Error 3")
        
        res.append(Instruction)
        res.append(result)
        res.append(operation)
        res.append(result_operator_name)
        

        #print("WB number: ", i," Instruction: ", Instruction," operation: ", operation," result out: ", result," Save record:", result_operator_name)
        

        # Review the order of the instructions and decide if I can run the Write stage



        if(operation == 1 or operation ==  2 or operation ==  3):             # ADD SUB MUL
            registers[result_operator_name] = result
        elif(operation == 4):           # STORE
            memory[result] = registers[result_operator_name]
        elif(operation == 5):           # LOAD
            registers[result_operator_name] = memory[result]

        i += 1



    n = 0
    while(n < len(instruction_state)):
        if(instruction_state[n][1] == "Write"):
            instruction_state[n][1] = "Done"
            instruction_state[n][2] = 1
            fin.append(instruction_state[n][0])
        n += 1
    
    temp = []


print("\n")
k = 0
while(k < len(instruction_state)):
    print(instruction_state[k])
    k += 1

print("\n")

print("Final state of memory")
print(memory)

print("\n")

print("Final state of the registers")
print(registers)