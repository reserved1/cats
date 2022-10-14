import Foundation
import UIKit

class RequirementViewModel {
    let tasks: [Requirement]

    init() {
        self.tasks = [
            Requirement("None 1"),
            Requirement("None 2")
        ]
    }

    init(_ tasks: [Requirement]) {
        self.tasks = tasks
    }

    func numberOfRows() -> Int {
        tasks.count
    }
    func makeCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath
    ) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "person.fill")
        content.text = task.text
        cell.accessoryType = task.isDone ? .checkmark : .none
        cell.contentConfiguration = content
        return cell
    }
    func deselectCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            let task = tasks[indexPath.row]
            task.isDone.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
}
