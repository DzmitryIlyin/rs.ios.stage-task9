//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/31/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SectionImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.locations = [0.51, 1]
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]

        self.layer.addSublayer(gradient)
    }
    
    private func removeGradient() {
        if let sublayer = self.layer.sublayers?[0] {
            sublayer.removeFromSuperlayer()
        }
    }
 
    override var bounds: CGRect {
        didSet
        {
            removeGradient()
            addGradient()
        }
    }
}

