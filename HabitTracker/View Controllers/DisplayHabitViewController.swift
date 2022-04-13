//
//  DisplayHabitViewController.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import UIKit

// Create new habit
class DisplayHabitViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var habitImageView: UIImageView!
    @IBOutlet weak var habitNameInputField: UITextField!
    @IBOutlet weak var createHabitButton: UIButton!
    
    var habitImage: Habit.Images!
    
    
    // MARK: - Lifecycle Hooks
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UI Set Up
        title = "New Habit"
        let attributedTitle = NSAttributedString(string: "CREATE HABIT", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .heavy)
        ])
        createHabitButton.layer.cornerRadius = 15
        createHabitButton.setAttributedTitle(attributedTitle, for: .normal)
        habitNameInputField.becomeFirstResponder()
        habitImageView.image = habitImage.image
    }
    
    
    // MARK: - IBAction
    
    @IBAction func createHabitTapped(_ sender: Any) {
        
        var persistenceLayer = PersistentLayer()
        guard let habitName = habitNameInputField.text else { return }
        
        persistenceLayer.createNewHabit(title: habitName, image: habitImage)
        persistenceLayer.setNeedsToReloadHabits()
        
        navigationController?.popToRootViewController(animated: true)
    }
    

}
