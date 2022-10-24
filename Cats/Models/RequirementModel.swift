import Foundation

class Requirement: Codable {
    let id: UUID
    var text: String
    var isDone: Bool = false

    init(_ text: String) {
        self.id = UUID()
        self.text = text
    }
}
