//  TaskListViewController.swift
//  Created by Camila Castaneda on 11/17/23.
//

import Foundation
import UIKit

class TaskListViewController: UITableViewController {

    // MARK: - Properties
    private let tasks = TaskDataProvider.HARDCODED_TASKS
    private let showTaskDetailSegueIdentifier = "ShowTaskDetailSegue"
    private var selectedTask: Task?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else {
            fatalError("Unable to dequeue a TaskCell.")
        }
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = tasks[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowTaskDetailSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTaskDetailSegue", let viewController = segue.destination as? TaskDetailViewController {
            viewController.task = selectedTask
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          tableView.reloadData() // Reload the table view data when the view appears
      }

    // MARK: - Private Helpers
    private func setupNavigationBar() {
        navigationItem.title = "National Parks"
        navigationItem.backButtonTitle = ""
    }
}
