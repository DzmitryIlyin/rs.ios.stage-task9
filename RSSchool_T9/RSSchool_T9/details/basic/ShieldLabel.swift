//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/1/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ShieldLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        self.font = UIFont(name: "Rockwell-Regular", size: 24)
        self.textColor = .white
        self.backgroundColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true;
    }
    
    override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: 8, left: 20, bottom: 3, right: 20)
            super.drawText(in: rect.inset(by: insets))
        }

        override var intrinsicContentSize: CGSize {
            let size = super.intrinsicContentSize
            return CGSize(width: size.width + 20 + 20,
                          height: size.height + 8 + 3)
        }
    
}
