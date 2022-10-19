import Foundation

protocol ViewCoding: AnyObject {
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
    }
}
