//
//  TableViewCell.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var streakCountLabel: UILabel!
    
    
    func configureHabits (_ habit: Habit) {
        
        self.titleLabel.text = habit.title
        self.streakCountLabel.text = "Streak: \(habit.currentStreak)"
        self.imageViewIcon.image = habit.selectedImage.image
        
        if habit.completedToday {
            self.accessoryType = .checkmark
            self.tintColor = UIColor.systemGreen
        } else {
            self.accessoryType = .disclosureIndicator
        }
    }
    
    
}
