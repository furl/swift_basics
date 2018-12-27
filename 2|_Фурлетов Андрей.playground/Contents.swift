import UIKit


func isEven(num: Int) -> Bool{
    guard num % 2 == 0 else {
        return false
    }
    return true
}

isEven(num: 3)
isEven(num: 0)

////////////////////////////////////////

func isMultipleOf(num: Int, divisor: Int) -> Bool{
    return num % divisor == 0 ? true : false
}

isMultipleOf(num: 9, divisor: 3)
isMultipleOf(num: 14, divisor: 3)

////////////////////////////////////////

var arr = [Int]()
for i in 1...100{
    arr.append(i)
}
arr

var tmparr = [Int]()
for i in 0..<arr.count{
    if !isEven(num: arr[i]) && isMultipleOf(num: arr[i], divisor: 3){
        tmparr.append(arr[i])
    }
}
arr = tmparr


////////////////////////////////////////


func generateFibonacciSequence(numOfElements: Int) -> [Double]{
    switch numOfElements{
    case 1:
        return [1.0]
    case 2:
        return [1.0,1.0]
    case let n where n <= 0:
        return [Double]()
    default:
        break
    }
    
    var fib = [Double]()
    var f2 = 1.0; fib.append(f2)
    var f1 = 1.0; fib.append(f1)
    var next = 0.0
    
    while fib.count < numOfElements{
        next = f1 + f2
        fib.append(next)
        f2 = f1
        f1 = next
    }
    return fib
}

generateFibonacciSequence(numOfElements: 10)

func isFibonacciNumber(num: Double) -> Bool{
    if num == 1{
        return true
    }
    var f2 = 1.0
    var f1 = 1.0
    var next = 0.0
    while next < num{
        next = f1 + f2
        f2 = f1
        f1 = next
        if next == num{
            return true
        }
    }
    return false
}

isFibonacciNumber(num: 15.0)
isFibonacciNumber(num: 13.0)

func isFibonacciSequence(array:[Double]) -> Bool{
    if array == generateFibonacciSequence(numOfElements: array.count){
        return true
    }else{
        return false
    }
}

isFibonacciSequence(array: [1.0,1.0,3.0])


func addFibonacciNumber(array: inout [Double]) -> Bool{
    switch array.count{
    case 0,1:
        array += [1.0]
        return true
    default:
        array += [array[array.count-2] + array[array.count-1]]
        return true
    }
}


var testarr = generateFibonacciSequence(numOfElements: 7)
//testarr = [9.0]
if isFibonacciSequence(array: testarr){
    for _ in 1...100{
        addFibonacciNumber(array: &testarr)
    }
}else{
    print("Your array is not a Fibonacci sequence, cannot add new numbers")
}

testarr
testarr.count

////////////////////////////////////////

/*
var primearr = [Int]()
primearr += 2...100
primearr
*/
let arraySize = 100

var primearr = Array(2...arraySize)
var p = 2
var indexP = 0
var end = false
while !end{
    for i in stride(from: indexP, to: primearr.count, by: p){
        if primearr[i] != p && primearr[i] != 0{
            primearr[i] = 0
        }
    }
    for i in indexP..<primearr.count{
        if primearr[i] > p{
            p = primearr[i]
            indexP = i
            break
        }else if i == primearr.count - 1{
            end = true
        }
    }
}
var tmparr2 = [Int]()
for element in primearr{
    if element != 0{
        tmparr2.append(element)
    }
}
primearr = tmparr2

primearr
