//
//  AlertControllerExtension.swift
//  HabitTracker
//
//  Created by Victoria Treue on 11/8/21.
//

import Foundation
import UIKit

extension UIAlertController {
    
    convenience init(habitTitle: String, confirmHandler: @escaping () -> Void) {
        
        self.init(title: "Delete Habit", message: "Are you sure you want to delte \(habitTitle) ?", preferredStyle: UIAlertController.Style.actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            confirmHandler()
        }
        self.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        self.addAction(cancelAction)
    }
}
