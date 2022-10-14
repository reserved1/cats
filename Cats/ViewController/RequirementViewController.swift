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
//        buildLayout()
    }

}

extension RequirementViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requirementViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        requirementViewModel.makeCell(tableView, indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        requirementViewModel.deselectCell(tableView, indexPath)
    }
}
