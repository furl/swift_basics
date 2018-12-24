import UIKit


let a = 2.0
let b = 3.0
let c = 4.0
let x = 5.0

func equation(a: Double, b: Double, c: Double, x: Double) -> Double{
    return a * pow(x, 2) + b * x + c
}

let y = equation(a: a, b: b, c: c, x: x)
print("\(y) = ax² + bx + c")

/////////////////////////////////////////////

let k1 = 3.0
let k2 = 4.0

func allAboutTriangle(k1:Double, k2:Double) -> (Double,Double,Double){
    let h = (k1 * k1 + k2 * k2).squareRoot()
    return (
        k1 * k2 / 2,
        k1 + k2 + h,
        h
    )
}

var (s,p,h) = allAboutTriangle(k1: k1, k2: k2)
print("Area: \(s), Perimeter: \(p), Hypotenuse: \(h)")

/////////////////////////////////////////////

var deposit = 100.0
let interest = 11.0

func bank(deposit: inout Double, interest: Double, years: Int) -> Double{
    for _ in 1...years {
        deposit += deposit * (interest/100)
    }
    return deposit
}

deposit = bank(deposit: &deposit, interest: interest, years: 5)

print("Bank deposit after 5 years: \((deposit * 100).rounded() / 100)")




