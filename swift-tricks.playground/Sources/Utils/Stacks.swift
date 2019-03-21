import Foundation

// https://docs.swift.org/swift-book/LanguageGuide/Generics.html


protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

struct Stack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element {
        return items.removeLast()
    }

    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> Element {
        return items[i]
    }
}

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

// https://docs.swift.org/swift-book/LanguageGuide/Generics.html
public func exampleStack() {
    var stack = Stack<String>()
    stack.append("10")
    stack.append("20")
    stack.append("30")
    stack.append("40")
    stack.append("50")

    let suffix = stack.suffix(2)
    print("suffix: \(suffix)")

    testTopValue(stack)
}

func testTopValue (_ stack: Stack<String>){
    guard let topItem = stack.topItem else {
        print("no top item")
        return
    }

    var valueGuessed = "tres"

    if stack.isTop(valueGuessed) {
        print("\(topItem) is tres.")
    } else {
        print("\(topItem) is something other than \(valueGuessed).")
    }

    valueGuessed = "50"
    if stack.isTop(valueGuessed) {
        print("\(topItem) is \(valueGuessed) (equivalence achieved).")
    } else {
        print("\(topItem) is something other than \(valueGuessed).")
    }
}
