import UIKit

enum WindowsState: String{
    case open, closed
}
enum EngineState: String{
    case running, stopped
}
enum CargoActions{
    case load, unload
}
enum TurboBoost: String{
    case on, off
}

protocol Driveable{
    var windowsState: WindowsState{get set}
    var engineState: EngineState{get set}
}

protocol CargoCarriable{
    var cargoAmount: Int{get set}
    var cargoSpace: Int{get}
}

protocol Raceable{
    var turboBoostState: TurboBoost{get set}
}

protocol ConsolePrintable: CustomStringConvertible{ //не совсем понял, для чего именно нужен CustomStringConvertible. Можно же написать свою функцию и description. Или это для примера наследования протоколов?
    func printDescription()
}

extension ConsolePrintable{
    func printDescription(){
        print(String(describing: self)) // здесь сделал в соответствии с рекомендациями документации (надеюсь, я правильно их понял)
    }
}

extension Driveable{
    mutating func toggleWindows(){
        if self.windowsState == .closed{
            print("Opening windows...")
            self.windowsState = .open
        }else{
            print("Closing windows...")
            self.windowsState = .closed
        }
    }
    mutating func toggleEngine(){
        if self.engineState == .stopped{
            print("Starting engine...")
            self.engineState = .running
        }else{
            print("Stopping engine...")
            self.engineState = .stopped
        }
    }
}

extension CargoCarriable{
    mutating func transferCargo(action: CargoActions, amount: Int){
        switch action {
        case .load:
            if self.cargoAmount + amount <= self.cargoSpace{
                self.cargoAmount += amount
                print("Cargo loaded. Amount: \(amount). Total cargo in trunk: \(self.cargoAmount)")
            }else{
                print("Not enough cargo space")
            }
        case .unload:
            if self.cargoAmount >= amount{
                self.cargoAmount -= amount
                print("Cargo unloaded. Amount: \(amount). Total cargo in trunk: \(self.cargoAmount)")
            }else{
                print("You're trying to unload more cargo than there is")
            }
        }
    }
}

extension Raceable{
    mutating func toggleTurboBoost(){
        if self.turboBoostState == .off{
            print("Activating turbo boost!")
            self.turboBoostState = .on
        }else{
            print("Dectivating turbo boost")
            self.turboBoostState = .off
        }
    }
}

class PickupTruck: Driveable, CargoCarriable, ConsolePrintable{
    var description: String{
        return "\n--- Pickup truck ---\n" +
        "Pickup truck cargo space: " + String(describing: cargoSpace) + "\n" +
        "Cargo amount: " + String(describing: cargoAmount) + "\n"
    }
    
    var cargoSpace: Int
    var cargoAmount: Int
    
    var engineState: EngineState{ // как можно здесь использовать приватный сеттер, чтобы не поломался mutating func toggleEngine?
        didSet{
            print("Engine is now \(self.engineState.rawValue)")
        }
    }
    
    var windowsState: WindowsState{
        didSet{
            print("Windows are now \(self.windowsState.rawValue)")
        }
    }
    
    init(cargoSpace: Int) {
        self.windowsState = .closed
        self.engineState = .stopped
        self.cargoAmount = 0
        self.cargoSpace = cargoSpace
    }
}

class SportsCar: Driveable, Raceable, ConsolePrintable{
    var description: String{
        return "\n--- Sports car ---\n" +
            "Sports car turbo boost state: " + String(turboBoostState.rawValue) + "\n"
    }
    
    var windowsState: WindowsState{
        didSet{
            print("Windows are now \(self.windowsState.rawValue)")
        }
    }
    var engineState: EngineState{
        didSet{
            print("Engine is now \(self.engineState.rawValue)")
        }
    }
    var turboBoostState: TurboBoost{
        didSet{
            print("Turbo boost is now \(self.turboBoostState.rawValue)")
        }
    }
    
    init() {
        self.windowsState = .closed
        self.engineState = .stopped
        self.turboBoostState = .off
    }
    
}

var myPickupTruck = PickupTruck(cargoSpace: 500)

myPickupTruck.windowsState
myPickupTruck.toggleWindows()
myPickupTruck.windowsState
myPickupTruck.toggleWindows()
myPickupTruck.windowsState

myPickupTruck.toggleEngine()
myPickupTruck.engineState

myPickupTruck.transferCargo(action: .load, amount: 200)
myPickupTruck.transferCargo(action: .load, amount: 200)
myPickupTruck.transferCargo(action: .load, amount: 200)
myPickupTruck.transferCargo(action: .unload, amount: 200)
myPickupTruck.transferCargo(action: .unload, amount: 100)
myPickupTruck.transferCargo(action: .unload, amount: 300)

myPickupTruck.printDescription()

print()

var mySportsCar = SportsCar()
mySportsCar.toggleTurboBoost()

mySportsCar.printDescription()
