import UIKit

class RequirementViewController: UIViewController {
// MARK: Properties for views/view models.
    var requirementViewModel: RequirementViewModel
    var requirementView: RequirementView
    var sheetRequirementView: SheetRequirementView
// MARK: Initializers.
    init() {
        self.requirementViewModel = RequirementViewModel()
        self.requirementView = RequirementView()
        self.sheetRequirementView = SheetRequirementView(Requirement(""))
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: View Lifecyle.
    override func loadView() {
        super.loadView()
        self.view = requirementView
        self.requirementView.tableView.dataSource = self
        self.requirementView.tableView.delegate = self
        Task {
            await requirementViewModel.changeBackground(self.requirementView.tableView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addRequirementAction()
        sheetButtonAction()
    }
// MARK: Closures and Actions for binding.
    // Binding for Requirement View Button/Action.
    private func addRequirementAction() {
        requirementView.addRequirement = { [weak self] in
            self?.showAddSheet()
        }
    }
    // Display for AddAction sheet.
    private func showAddSheet() {
        self.sheetRequirementView.textField.text = ""
        self.sheetRequirementView.flag = false
        let navController = UINavigationController(rootViewController: self.sheetRequirementView)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                0.25 * context.maximumDetentValue
            })]
    }
        self.present(navController, animated: true)
    }
    // Binding for Sheet Requirement View Button/Action.
    private func sheetButtonAction() {
        sheetRequirementView.confirmButton = { [weak self] in
            self?.addRequirementButton()
        }
    }
    // Call for Create or Update content from Sheet Requirement View Button.
    private func addRequirementButton() {
        if !sheetRequirementView.textField.text!.isEmpty {
            if sheetRequirementView.flag == false {
                requirementViewModel.addToRequirements(sheetRequirementView.textField.text!)
                requirementView.tableView.reloadData()
                Task {
                    await requirementViewModel.changeBackground(self.requirementView.tableView)
                }
            } else {
                requirementViewModel.edittedRequirement?.text = sheetRequirementView.textField.text!
                for index in requirementViewModel.requirements
                where index.id == requirementViewModel.edittedRequirement?.id {
                    index.text = requirementViewModel.edittedRequirement!.text
                }
                requirementView.tableView.reloadData()
                Task {
                    await requirementViewModel.changeBackground(self.requirementView.tableView)
                }
            }
        }
        requirementViewModel.saveRequirements()
    }
}
