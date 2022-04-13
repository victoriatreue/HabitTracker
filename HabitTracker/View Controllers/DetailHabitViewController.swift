//
//  DetailHabitViewController.swift
//  HabitTracker
//
//  Created by Victoria Treue on 11/8/21.
//

import UIKit

class DetailHabitViewController: UIViewController {

    // MARK: - Properties
    
    var habit: Habit!
    var habitIndex: Int!
    
    private var persistence = PersistentLayer()
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelCurrentStreak: UILabel!
    @IBOutlet weak var labelTotalCompletions: UILabel!
    @IBOutlet weak var labelBestStreak: UILabel!
    @IBOutlet weak var labelStartingDate: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    
    
    // MARK: - Lifecycle Hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAction.setTitleColor(UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), for: .normal)
        buttonAction.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        buttonAction.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    
    // MARK: - Helper Functions
    
    private func updateUI() {
        
        title = habit.title
        imageViewIcon.image = habit.selectedImage.image
        
        if habit.currentStreak == 1 { labelCurrentStreak.text = "\(habit.currentStreak) day"
        } else { labelCurrentStreak.text = "\(habit.currentStreak) days" }
        
        labelTotalCompletions.text = String(habit.numberOfCompletions)
        labelBestStreak.text = String(habit.bestStreak)
        labelStartingDate.text = habit.dateCreated.convertToString()
        
        if habit.completedToday {
            buttonAction.setTitle("Completed for Today!", for: .normal)
        } else {
            buttonAction.setTitle("Mark as Completed!", for: .normal)
        }
        
    }
    
    // MARK: - IBActions
    
    @IBAction func markAsCompletedTapped(_ sender: Any) {
        
        habit = persistence.markHabitAsCompleted(habitIndex)
        updateUI()
    }
}
