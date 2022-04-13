//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pickPhotoButton: UIButton!
    
    
    let habitImages = Habit.Images.allCases
    
    let cell = HabitCollectionViewCell()
    
    // Create a property to track which indexPath gets selected
    var selectedIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let selectedIndexPath = selectedIndexPath {
                indexPaths.append(selectedIndexPath)
            }
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            imageCollectionView.performBatchUpdates {
                self.imageCollectionView.reloadData()
            }
        }
    }
    
    
    // MARK: - Lifecycle Hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Set Up
        let attributedTitle = NSAttributedString(string: "PICK PHOTO", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .heavy)
        ])
        pickPhotoButton.layer.cornerRadius = 15
        pickPhotoButton.setAttributedTitle(attributedTitle, for: .normal)
        imageCollectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        imageCollectionView.showsVerticalScrollIndicator = false
        
        // Combine Nib File with Collection View
        imageCollectionView.register(HabitCollectionViewCell.nib, forCellWithReuseIdentifier: "collectionCell")
        
        setUpNavBar()
    }
    
    
    // MARK: - Helper Functions
    
    func setUpNavBar () {
        title = "Select Image"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancelButtonTapped (_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func pickPhotoButtonTapped(_ sender: Any) {
        
        guard let selectedIndexPath = selectedIndexPath else { return }
        let displayVC = storyboard?.instantiateViewController(identifier: "displayVC") as! DisplayHabitViewController
        displayVC.habitImage = habitImages[selectedIndexPath.row]
        navigationController?.pushViewController(displayVC, animated: true)
    }

}


// MARK: - EXTENSION

extension AddHabitViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    // MARK: - Delegete and Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
        
        let displayImage = habitImages[indexPath.row].image
        
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.setImage(image: displayImage, withSelection: false)
        cell.habitImage.alpha = 0.3
        
        return cell
    }

    
    
    // MARK: - Collection View Order
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/4, height: collectionViewWidth/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
            if let cell = collectionView.cellForItem(at: indexPath) as? HabitCollectionViewCell {
                cell.habitImage.alpha = 0.3
            }
        } else {
            selectedIndexPath = indexPath
            if let cell = collectionView.cellForItem(at: indexPath) as? HabitCollectionViewCell {
                for everyCell in collectionView.visibleCells {
                    if let everyHaibtCell = everyCell as? HabitCollectionViewCell {
                        everyHaibtCell.habitImage.alpha = 0.3
                    }
                }
                cell.habitImage.alpha = 1.0
            }
        }
        return false
    }
}
