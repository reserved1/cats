import UIKit

class RequirementView: UIView {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return table
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Requirements"
        title.font = .boldSystemFont(ofSize: 30)
        title.translatesAutoresizingMaskIntoConstraints = false

        return title
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.buildLayout()
    }

}

extension RequirementView: ViewCoding {

    func setupHierarchy() {
        self.addSubview(self.tableView)
        self.addSubview(self.titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        ])
    }
}
