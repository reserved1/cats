import Foundation
import UIKit

extension RequirementViewController: UITableViewDataSource, UITableViewDelegate {
// MARK: Delegate and DataSource for TableView.
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
        Task {
            await requirementViewModel.changeBackground(self.requirementView.tableView)
        }
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = requirementViewModel.deleteCell(tableView, indexPath)
        let edit = requirementViewModel.updateCell(
            requirementViewModel.requirements[indexPath.row],
            self, sheetRequirementView
        )
        let config = UISwipeActionsConfiguration(actions: [edit, delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

}
