import Foundation

// https://docs.swift.org/swift-book/LanguageGuide/Generics.html

public func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

public func exampleSwap() {
    var foo = "foo"
    var bar = "bar"
    print("foo = \(foo), bar = \(bar)")

    swapTwoValues(&foo, &bar)

    print("foo = \(foo), bar = \(bar)")
}
