//
//  PersistentLayer.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import Foundation
import UIKit

struct PersistentLayer {
    
    // 1: We only want our array of habits be accessed through the PersistentLayer 'private'
    private(set) var habits: [Habit] = []
    
    // 2: We only want once instance of this property, that's why 'static'
    private static let userDefaultHabitsKeyValue = "HABITS_ARRAY"
    
    // 3: Initalise
    init() {
        self.loadHabits()
    }
    
    // 4: Function to decode habits and display to user
    mutating func loadHabits() {
        let userDefaults = UserDefaults.standard
        guard let habitData = userDefaults.data(forKey: PersistentLayer.userDefaultHabitsKeyValue),
              let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else { return }
        self.habits = habits
    }
    
    // 5: Creating a new Habit
    // 'discardableResult' because we won't be using result directly
    @discardableResult
    mutating func createNewHabit(title: String, image: Habit.Images) -> Habit {
        
        let newHabit = Habit(title: title, image: image)
        self.habits.insert(newHabit, at: 0)
        self.saveHabits()
        
        return newHabit
    }
    
    // 6: Save a new habit by using Encoder
    private func saveHabits() {
        
        guard let habitsData = try? JSONEncoder().encode(self.habits) else { fatalError("Could not encode list of habits.") }
        
        // 7: Setting habitData (json data) inside User Defaults for its given key
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistentLayer.userDefaultHabitsKeyValue)
        userDefaults.synchronize()
    }
    
    // 8: Delete habits by given index & persist made changes
    mutating func deleteHabtis (_ habitIndex: Int) {
        
        self.habits.remove(at: habitIndex)
        self.saveHabits()
    }
    
    // 9: Complete a habit
    mutating func markHabitAsCompleted (_ habitIndex: Int) -> Habit {
        
        // Variable stores habit at given inidex
        var updateHabit = self.habits[habitIndex]
        
        // 10: Check if habit has been completed for that given day
        guard updateHabit.completedToday == false else { return updateHabit}
        updateHabit.numberOfCompletions += 1
        
        // 11: Check if last Completion Date was yesterday & update Streak Count
        if let lastCompletionDate = updateHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updateHabit.currentStreak += 1
        } else {
            updateHabit.currentStreak = 1
        }

        // 12: Check for a new 'bestStreak' by comparing it to currentStreak
        if updateHabit.currentStreak > updateHabit.bestStreak {
            updateHabit.bestStreak = updateHabit.currentStreak
        }
        
        // 13: Update last completion date
        let now = Date()
        updateHabit.lastCompletionDate = now
        
        // 14: Update habit
        self.habits[habitIndex] = updateHabit
        
        // 15: Save changes and return newly updated Array
        self.saveHabits()
        return updateHabit
    }
    
    // 16: Swap habits (by importance if wanted)
    mutating func swapHabits (habitIndex: Int, destinationIndex: Int) {
        
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    
    // 17: Present habits to TableView after updating
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
}
