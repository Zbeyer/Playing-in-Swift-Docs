import Foundation

// https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html

public struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    public init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    public subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

public func exampleMatrix() {
    var matrix = Matrix(rows: 2, columns: 2)
    let someValue = matrix[1, 1]
    print("matrix[1, 1] = \(someValue). \(matrix)")
}
