//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/31/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class HomeImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        addGradient()
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.locations = [0.74, 1]
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
