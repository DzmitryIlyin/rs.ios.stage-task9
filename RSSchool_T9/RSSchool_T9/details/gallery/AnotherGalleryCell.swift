//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/4/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

protocol ConstaintInvalidation {
    func setConstraints(orientation: UIInterfaceOrientation)
}

class AnotherGalleryCell: UICollectionViewCell {
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageViewData: UIImage? {
        didSet {
            galleryImageView.image = imageViewData
        }
    }
    
    private lazy var galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var borderView: UIView = {
        let borderView = UIView()
        borderView.backgroundColor = .clear
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.white.cgColor
        borderView.layer.cornerRadius = 8
        borderView.translatesAutoresizingMaskIntoConstraints = false
        return borderView
    }()
    
    private func setupCell() {
        self.contentView.addSubview(borderView)
        self.contentView.addSubview(galleryImageView)
        prepareConstraints()
        
        let orientation = (UIApplication.shared.windows.first?.windowScene?.interfaceOrientation)!
        changeAndUpdateConstraints(orientation: orientation)
    }
    
    private func changeAndUpdateConstraints(orientation: UIInterfaceOrientation) {
        if orientation.isPortrait {
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
        } else {
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
        }
        layoutIfNeeded()
        layoutSubviews()
    }
    
    private func prepareConstraints() {
        portrait = [
            borderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            borderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            borderView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            borderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            galleryImageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10),
            galleryImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -10),
            galleryImageView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 10),
            galleryImageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -10),
        ]
        landscape = [
            borderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 150),
            borderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -150),
            borderView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            borderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            galleryImageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10),
            galleryImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -10),
            galleryImageView.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 10),
            galleryImageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -10),
        ]
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded() 
        var frame = layoutAttributes.frame
        frame.size.height = frame.size.width * 1.37
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
}

extension AnotherGalleryCell: ConstaintInvalidation {
    func setConstraints(orientation: UIInterfaceOrientation) {
        self.changeAndUpdateConstraints(orientation: orientation)
    }
    
}
