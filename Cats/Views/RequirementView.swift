import UIKit

class RequirementView: UIView {
// MARK: Properties for Requirement View.
    var addRequirement: ( () -> Void )?

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Requirements"
        title.textColor = .label
        title.font = .boldSystemFont(ofSize: 30)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .label
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
// MARK: View Lifecyle.
    override func layoutSubviews() {
        super.layoutSubviews()
        self.buildLayout()
        self.backgroundColor = .systemBackground
        addButton.addTarget(self, action: #selector(addRequirementButton), for: .touchUpInside)
    }
    // Binding for closure addRequirement. Used on Requirement View Controller.
    @objc private func addRequirementButton() {
        addRequirement?()
    }
}
// MARK: Setup view`s components and constraints.
extension RequirementView: ViewCoding {
    func setupHierarchy() {
        self.addSubview(self.tableView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.addButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            addButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 50),
            addButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -50),
            addButton.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -50)

        ])
    }
}
