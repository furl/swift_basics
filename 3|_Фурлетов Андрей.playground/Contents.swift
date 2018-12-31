import UIKit



struct Vehicle{
    
    enum VehicleType{
        case car
        case van
        case truck
        case bus
    }
    enum EngineState{
        case on
        case off
    }
    enum WindowsState{
        case open
        case closed
    }
    enum VehicleActions {
        case startEngine
        case stopEngine
        case openWindows
        case closeWindows
        case loadCargo (amount: Int)
        case unloadCargo (amount: Int)
    }
    
    let vehicleType: VehicleType //зачем копировать весь этот код и создавать дополнительные структуры, когда можно обойтись одним свойством? DRY
    let model: String
    let year: Int
    let cargoSpace: Int // liters
    private(set) public var cargoInTrunk: Int
    var engineState: EngineState
    var windowsState: WindowsState
    
    init?(vehicleType: VehicleType, model: String, year: Int, cargoSpace: Int, cargoInTrunk: Int, engineState: EngineState, windowsState: WindowsState){
        guard year >= 1769 && year <= Int(Date().description.prefix(4))! else { return nil }
        guard cargoSpace >= 0 else { return nil }
        guard cargoInTrunk >= 0 && cargoInTrunk <= cargoSpace else { return nil }
        
        self.vehicleType = vehicleType
        self.model = model
        self.year = year
        self.cargoSpace = cargoSpace
        self.cargoInTrunk = cargoInTrunk
        self.engineState = engineState
        self.windowsState = windowsState
    }
    
    mutating func doSomethingWithVehicle(namely action: VehicleActions){
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
        case .loadCargo(let amount):
            let freeSpace = self.cargoSpace - self.cargoInTrunk
            if (amount <= freeSpace) && (amount >= 0) {
                self.cargoInTrunk += amount
            }else{ //да, тут можно было сделать UInt, но мне очень нравится эта конструкция
                print("Cannot load cargo. Reason: " + (amount >= 0 ? "not enough cargo space for \(amount) units. Space available: \(freeSpace)" : "negative amount of cargo"))
            }
        case .unloadCargo(let amount):
            if (amount <= self.cargoInTrunk) {
                self.cargoInTrunk -= amount
            }else{
                print("Cannot unload cargo. Reason: " + (amount >= 0 ? "you're trying to unload more cargo (\(amount)) than there is (\(self.cargoInTrunk))." : "negative amount of cargo"))
            }
            
        }//switch
        
    }//mutating func doSomethingWithVehicle(namely action: VehicleActions){
    
}//struct Car



if var myCar = Vehicle(vehicleType: .car, model: "Lotus Esprit S1", year: 1976, cargoSpace: 50, cargoInTrunk: 0, engineState: .off, windowsState: .closed){
    myCar.doSomethingWithVehicle(namely: .loadCargo(amount: 20))
    myCar.doSomethingWithVehicle(namely: .unloadCargo(amount: 10))
    myCar.doSomethingWithVehicle(namely: .openWindows)
    myCar.doSomethingWithVehicle(namely: .openWindows)
    myCar.doSomethingWithVehicle(namely: .closeWindows)
    myCar.doSomethingWithVehicle(namely: .startEngine)

    myCar.windowsState = .open
    
}else{
    print("Invalid Vehicle init")
}

print ("-----------------------")
if var myTruck = Vehicle(vehicleType: .truck, model: "Volvo FM", year: 2013, cargoSpace: 112000, cargoInTrunk: 0, engineState: .off, windowsState: .closed){
    myTruck.doSomethingWithVehicle(namely: .loadCargo(amount: 200000))
    myTruck.doSomethingWithVehicle(namely: .openWindows)
    myTruck.doSomethingWithVehicle(namely: .openWindows)
    myTruck.doSomethingWithVehicle(namely: .closeWindows)
    myTruck.doSomethingWithVehicle(namely: .startEngine)
    
}else{
    print("Invalid Vehicle init")
}
