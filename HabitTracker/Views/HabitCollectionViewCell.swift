//
//  HabitCollectionViewCell.swift
//  HabitTracker
//
//  Created by Victoria Treue on 10/8/21.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var habitImage: UIImageView!
        
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

        
    func setImage (image: UIImage, withSelection: Bool) {

        self.habitImage.image = image.withRenderingMode(.alwaysOriginal)

        if withSelection {
            self.habitImage.layer.borderColor = UIColor.black.cgColor
            self.habitImage.layer.borderWidth = 1.0
        }
        
    }

}
