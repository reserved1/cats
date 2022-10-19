import Foundation
import UIKit

class RequirementViewModel {

    var requirements: [Requirement] = []

    init() {
        if FileManager().docExist(named: fileName) {
            loadRequirements()
        }
    }

    func addToRequirements(_ requirementText: String) {
        let newRequirement = Requirement(requirementText)
        self.requirements.append(newRequirement)
        saveRequirements()
    }

// Table View Related Functions
    func numberOfRows() -> Int {
        requirements.count
    }

    func makeCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) -> UITableViewCell {
        let requirement = requirements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "person.fill") // gato
        content.text = requirement.text
        cell.accessoryType = requirement.isDone ? .checkmark : .none
        cell.contentConfiguration = content
        return cell
    }

    func deselectCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let requirement = requirements[indexPath.row]
        requirement.isDone.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func updateCell(
        _ requirement: Requirement,
        _ tableView: UITableView
    ) -> UIContextualAction {
        let action = UIContextualAction(
            style: .normal,
            title: "Edit"
        ) { [weak self] (_, _, completionHandler) in
            guard let index = self?.requirements.firstIndex(where: { $0.id == requirement.id }) else { return }
            self?.requirements[index] = Requirement("Editable")
            self?.saveRequirements()
            tableView.reloadData()
            completionHandler(true)
        }
        action.backgroundColor = .systemOrange
        return action
    }

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

// Persistence Related Functions
    func loadRequirements() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    requirements = try decoder.decode([Requirement].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func saveRequirements() {
        let enconder = JSONEncoder()
        do {
            let data = try enconder.encode(requirements)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
