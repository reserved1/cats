import UIKit

class RequirementViewController: UIViewController {

    private var requirementViewModel: RequirementViewModel
    private var requirementView: RequirementView

    init() {
        self.requirementViewModel = RequirementViewModel()
        self.requirementView = RequirementView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = requirementView
        self.requirementView.tableView.dataSource = self
        self.requirementView.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addAction()
    }

    private func addAction() {
        requirementView.addTask = { [weak self] in
            self?.addAlert()
        }
    }

    private func addAlert() {
        let alertController = UIAlertController(title: "Enter a new requirement", message: nil, preferredStyle: .alert)
        alertController.viewRespectsSystemMinimumLayoutMargins = true
        alertController.addTextField()
        let submitAction = UIAlertAction(title: "Save", style: .default) { [unowned alertController] _ in
            let answer = alertController.textFields![0]
            if !answer.text!.isEmpty {
                self.requirementViewModel.addToRequirements(answer.text!)
                self.requirementView.tableView.reloadData()
            }
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
}

extension RequirementViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        requirementViewModel.numberOfRows()
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        requirementViewModel.makeCell(tableView, indexPath)
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        requirementViewModel.deselectCell(tableView, indexPath)
    }

}

extension RequirementViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let delete = requirementViewModel.deleteCell(tableView, indexPath)
        let edit = requirementViewModel.updateCell(requirementViewModel.requirements[indexPath.row], tableView)

        let config = UISwipeActionsConfiguration(actions: [edit, delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}
