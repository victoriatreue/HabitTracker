//
//  HabitsTableViewController.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import UIKit
import Foundation


class HabitsTableViewController: UITableViewController, UISearchResultsUpdating {

    // MARK: - Properties
    
    var habits: [Habit] = []
    
    // Create and instance of the PersistentLayer()
    private var persistence = PersistentLayer()

    // Add Search Bar by creating an instance of UISearchController()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - Lifecycle Hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Search Controller to the View
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        // Edit button
        navigationItem.leftBarButtonItem = self.editButtonItem

        // Load habits
        persistence.setNeedsToReloadHabits()
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            self?.persistence.setNeedsToReloadHabits()
            self?.tableView.reloadData()
        }
    }
    

    // MARK: - Implementation for Search Controller
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        // TODO: - Add a ResultVC and add functionality for it here
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistence.habits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! TableViewCell

        let habit = persistence.habits[indexPath.row]
        cell.configureHabits(habit)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedHabit = persistence.habits[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(identifier: "detailVC") as! DetailHabitViewController
        
        detailVC.habit = selectedHabit
        detailVC.habitIndex = indexPath.row
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            // Handle the delete action
            let habitToDelete = persistence.habits[indexPath.row]
            let habitIndexToDelete = indexPath.row
            
            // Show an Alert to confirm the delete action / cancel
            let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
                self.persistence.deleteHabtis(habitIndexToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            self.present(deleteAlert, animated: true, completion: nil)
            
        default: break
        }
    }
    
    // Swap Habits based on the .swapHabits() method in the Persistence Layer
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        persistence.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


    // MARK: - IBAction
    
    @IBAction func pressAddHabit(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: "addHabit") as! AddHabitViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
