import UIKit

class Car{
    
    enum EngineState{
        case on, off
    }
    enum WindowsState{
        case open, closed
    }
    enum CarActions {
        case startEngine
        case stopEngine
        case openWindows
        case closeWindows
        case carryCargo
        case injectN₂O
    }
    
    let numberOfDoors: Int
    let numberOfSeats: Int
    let maxSpeed: Int
    
    var engineState: EngineState
    var windowsState: WindowsState
    
    init(numberOfDoors: Int, numberOfSeats: Int, maxSpeed: Int, engineState: EngineState = .off, windowsState: WindowsState = .closed){
        self.numberOfDoors = numberOfDoors
        self.numberOfSeats = numberOfSeats
        self.maxSpeed = maxSpeed
        self.engineState = engineState
        self.windowsState = windowsState
    }
    
    func doSomethingWithVehicle(namely action: CarActions){
    }
}

class PickupTruck: Car{
    let cargoSpace: Int
    
    init(numberOfDoors: Int, numberOfSeats: Int, maxSpeed: Int, cargoSpace: Int) {
        self.cargoSpace = cargoSpace
        super.init(numberOfDoors: numberOfDoors, numberOfSeats: numberOfSeats, maxSpeed: maxSpeed, engineState: .off, windowsState: .closed)
    }
    
    override func doSomethingWithVehicle(namely action: Car.CarActions) {
        switch action {
        case .startEngine:
            if self.engineState == .off{
                self.engineState = .on
                print("Starting engine...")
            }else{
                print("Engine is already running")
            }
        case .stopEngine:
            if self.engineState == .on{
                self.engineState = .off
                print("Stopping engine...")
            }else{
                print("Engine is already stopped")
            }
        case .openWindows:
            if self.windowsState == .closed{
                self.windowsState = .open
                print("Opening windows...")
            }else{
                print("Windows are already opened")
            }
        case .closeWindows:
            if self.windowsState == .open{
                self.windowsState = .closed
                print("Closing windows...")
            }else{
                print("Windows are already closed")
            }
        case .carryCargo:
            print("Carrying cargo, that's what pickup truck was made for!")
        default:
            print("This type of car does not support specified action")
        }
    }
}

class SportsCar: Car{
    let N₂OTank: Int
    init(numberOfDoors: Int, numberOfSeats: Int, maxSpeed: Int, N2OTank: Int) {
        self.N₂OTank = N2OTank
        super.init(numberOfDoors: numberOfDoors, numberOfSeats: numberOfSeats, maxSpeed: maxSpeed, engineState: .off, windowsState: .closed)
    }
    override func doSomethingWithVehicle(namely action: Car.CarActions) {
        switch action {
        case .startEngine:
            if self.engineState == .off{
                self.engineState = .on
                print("Starting engine...")
            }else{
                print("Engine is already running")
            }
        case .stopEngine:
            if self.engineState == .on{
                self.engineState = .off
                print("Stopping engine...")
            }else{
                print("Engine is already stopped")
            }
        case .openWindows:
            if self.windowsState == .closed{
                self.windowsState = .open
                print("Opening windows...")
            }else{
                print("Windows are already opened")
            }
        case .closeWindows:
            if self.windowsState == .open{
                self.windowsState = .closed
                print("Closing windows...")
            }else{
                print("Windows are already closed")
            }
        case .injectN₂O:
            print("Injecting N₂O! Happy racing!")
        default:
            print("This type of car does not support specified action")
        }
    } // Можно ли здесь избавиться от копирования всего этого кода? Есть идея создать отдельную функцию для специальных действий, уникальных для наследников, а также отдельный enum для этих действий. А потом делать оверрайд этой функции, а родительскую функцию с общими действиями для всех машин оставить как есть. Или есть более правильный способ?
}

let myTruck = PickupTruck(numberOfDoors: 4, numberOfSeats: 5, maxSpeed: 180, cargoSpace: 500)

myTruck.doSomethingWithVehicle(namely: .openWindows)
myTruck.doSomethingWithVehicle(namely: .carryCargo)
myTruck.doSomethingWithVehicle(namely: .injectN₂O)
print("Cargo space: \(myTruck.cargoSpace)")

print("-----------------------------------")

let mySportsCar = SportsCar(numberOfDoors: 2, numberOfSeats: 2, maxSpeed: 250, N2OTank: 10)

mySportsCar.doSomethingWithVehicle(namely: .startEngine)
mySportsCar.doSomethingWithVehicle(namely: .injectN₂O)
mySportsCar.doSomethingWithVehicle(namely: .carryCargo)
print("N₂O tank: \(mySportsCar.N₂OTank)")
