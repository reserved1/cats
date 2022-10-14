import Foundation

class Requirement {
    let text: String
    var isDone: Bool = false

    init(_ text: String) {
        self.text = text
    }
}
