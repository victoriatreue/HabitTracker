//
//  DateExtensions.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import Foundation
import UIKit


extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    
    var isToday: Bool {
        let calender = Calendar.current
        return calender.isDateInToday(self)
    }

    var isYesterday: Bool {
        let calender = Calendar.current
        return calender.isDateInYesterday(self)
    }
    
}
