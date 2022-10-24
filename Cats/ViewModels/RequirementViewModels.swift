import Foundation
import UIKit

class RequirementViewModel {

    var requirements: [Requirement] = []

    var edittedRequirement: Requirement?
// MARK: Initializer using FileManager.
    init() {
        if FileManager().docExist(named: fileName) {
            loadRequirements()
        }
    }
    // Add content to our list of requirements. Act as a Create Function for CRUD in list.
    func addToRequirements(_ requirementText: String) {
        let newRequirement = Requirement(requirementText)
        self.requirements.append(newRequirement)
        saveRequirements()
    }

// MARK: Table View Related Functions.
    // DataSource for TableView`s row.
    func numberOfRows() -> Int {
        requirements.count
    }
    // Change TableView`s background on many steps.
    // Use GET method from UIImageView extension.
    // Request @MainActor for main thread purpose.
    @MainActor
    func changeBackground(_ tableView: UITableView) async {
        let imageView = UIImageView()
        let url = URL(string: "https://http.cat/"+(Api.catImages.randomElement() ?? "404"))
        await imageView.getCatImages(url!)
        tableView.reloadData()
        tableView.backgroundView = imageView
        tableView.backgroundView?.contentMode = .scaleAspectFit
    }
    // DataSource for TableView`s content. Act as a Read Function for CRUD in list.
    func makeCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) -> UITableViewCell {
        let requirement = requirements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = requirement.text
        cell.accessoryType = requirement.isDone ? .checkmark : .none
        cell.contentConfiguration = content
        return cell
    }
    // Used in Delegate for TableView`s cell selection/deselection.
    func deselectCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let requirement = requirements[indexPath.row]
        requirement.isDone.toggle()
        self.saveRequirements()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    // Used in Delegate for TableView`s content. Act as an Update Function for CRUD in list.
    func updateCell(
        _ requirement: Requirement,
        _ view: UIViewController,
        _ sheet: SheetRequirementView
    ) -> UIContextualAction {
        let action = UIContextualAction(
            style: .normal,
            title: "Edit"
        ) { (_, _, completionHandler) in
            sheet.flag = true
            sheet.textField.text = requirement.text
            self.edittedRequirement = requirement
            let navController = UINavigationController(rootViewController: sheet)
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [.custom(resolver: { context in
                    0.25 * context.maximumDetentValue
                })]
            }
            view.present(navController, animated: true)
            completionHandler(true)
        }
        action.backgroundColor = .systemOrange
        return action
    }
    // Used in Delegate for TableView`s content. Act as a Delete Function for CRUD in list.
    func deleteCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) -> UIContextualAction {
        let action = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] (_, _, completionHandler) in
            self?.requirements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            self?.saveRequirements()
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return action
    }
}
