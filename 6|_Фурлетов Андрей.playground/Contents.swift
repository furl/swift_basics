import UIKit

protocol StrangeThings{
    var strangenessLevel: Int { get set }
}

// далее я написал возможно какую-то лютую дичь, но я хотел, чтобы очередь работала со всеми типами, поддерживающими протокол StrangeThings в одном массиве
struct Queue<T>{
    var queueArray = [T]()
    
    mutating func enqueue(element: T){
        queueArray.append(element)
    }
    
    mutating func dequeue() -> T? {
        guard queueArray.count > 0 else {
            return nil
        }
        return queueArray.removeFirst()
    }
    
    var count: Int{
        return queueArray.count
    }
    
    mutating func makeKnivesGolden(){
        var knivesCount = 0
        for element in queueArray{
            if element is Knife{
                knivesCount += 1
                (element as! Knife).material = .gold
                (element as! Knife).strangenessLevel = 9
            }
        }
        if knivesCount > 0{
            print("All \(knivesCount) knives are now golden!")
        }else{
            print("No knives found")
        }
    }
    
    func printAll(){
        print()
        for element in queueArray{
            print(element, (element is StrangeThings ? "- strangeness level: \((element as! StrangeThings).strangenessLevel)" : ""))
        }
        print()
    }
    
    func filterStrangeThingsUsingPredicate(condition: (Int)->Bool) -> [StrangeThings]{
        var filteredThings = [StrangeThings]()
        for element in queueArray{
            if element is StrangeThings && condition((element as! StrangeThings).strangenessLevel){
                filteredThings.append(element as! StrangeThings)
            }
        }
        return filteredThings
    }
    
    subscript(index: Int) -> T? {
        if index < queueArray.count{
            return queueArray[index]
        }else{
            return nil
        }
    }
}

class Person: CustomStringConvertible, StrangeThings{
    var strangenessLevel: Int
    
    var description: String { return String(describing: name) }
    
    var name: String
    
    init(name: String, strangenessLevel: Int = 2) {
        self.name = name
        self.strangenessLevel = strangenessLevel
    }
}

enum Material{
    case steel, silver, plastic, gold
}

class Knife: CustomStringConvertible, StrangeThings{
    var strangenessLevel: Int
    
    var description: String { return String(describing: self.material) + " knife" }
    
    var material: Material
    
    init(material: Material, strangenessLevel: Int = 1) {
        self.material = material
        self.strangenessLevel = strangenessLevel
    }
}

// MARK: intArray test
var intArray = [1,2,3]
var intQueue = Queue<Int>()

for element in intArray{
    intQueue.enqueue(element: element)
}
intQueue.printAll()
intQueue.makeKnivesGolden() // это не имеет никакого смысла, но хотя бы не вызывает ошибок. Возможно, это было не лучшее архитектурное решение, может того же самого можно как-то добиться через наследование протоколов? Например создать родительский протокол AllThings и от него дочерний StrangeThings, и следовательно struct Queue<T: AllThings>, чтобы очередь не поддерживала всякие случайные типы вроде Int
intQueue.filterStrangeThingsUsingPredicate(){ $0 > 2 }
intQueue[0]
intQueue[5]
for _ in 0...5{
    intQueue.dequeue()
}
intQueue[0]

var strangeArray: [StrangeThings] = [
    Person(name: "John Cena", strangenessLevel: 3),
    Knife(material: .silver),
    Person(name: "Mary Poppins"),
    Knife(material: .steel, strangenessLevel: 0),
    Person(name: "Donald Trump", strangenessLevel: 6)
]


var uncombinableThings = Queue<StrangeThings>()

for element in strangeArray{
    uncombinableThings.enqueue(element: element)
}

uncombinableThings.printAll()

let reallyStrangeThings = uncombinableThings.filterStrangeThingsUsingPredicate() { $0 > 2 }
reallyStrangeThings

let lottery = uncombinableThings.filterStrangeThingsUsingPredicate() { $0 == Int.random(in: 0...5) } // sometimes you get nothing
lottery
uncombinableThings.makeKnivesGolden()
uncombinableThings.printAll()
uncombinableThings[0]

for _ in 1...10 {
    if let uncombinableThing = uncombinableThings.dequeue(){
        print("Dequeued: \(uncombinableThing)")
    }else{
        print("No more elements in queue")
    }
    
}
uncombinableThings[0]
