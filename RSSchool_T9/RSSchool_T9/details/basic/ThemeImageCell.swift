//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/30/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ThemeImageCell: UICollectionViewCell {
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
        
    var imageData: UIImage? {
        didSet {
            sectionImageView.image = imageData
        }
    }
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()
    
    let sectionImageView: SectionImageView = {
       let imageView = SectionImageView(frame: .zero)
       return imageView
   }()
    
    var titleData: String? {
        didSet {
            titleLabel.text = titleData
        }
    }
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Rockwell-Regular", size: 48)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    var typeData: String? {
        didSet {
            typeLabel.text = typeData
        }
    }
    
    private let typeLabel: ShieldLabel = {
        let typeLabel = ShieldLabel()
        return typeLabel
    }()
         
    private let dividerLineView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        return dividerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.sectionImageView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.typeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(closeButton)
        self.contentView.addSubview(sectionImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(dividerLineView)
        
        sectionImageView.bringSubviewToFront(typeLabel)

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
    
    func prepareConstraints() {
        let dimensionBefore = typeLabel.centerYAnchor.anchorWithOffset(to: sectionImageView.bottomAnchor)
        let dimensionAfter = sectionImageView.bottomAnchor.anchorWithOffset(to: sectionImageView.bottomAnchor)
        
        portrait = [
        closeButton.heightAnchor.constraint(equalToConstant: 40),
        closeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
        closeButton.widthAnchor.constraint(equalToConstant: 40),
        closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

        sectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        sectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        sectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
        sectionImageView.bottomAnchor.constraint(equalTo: dividerLineView.topAnchor, constant: -65),
        
        titleLabel.leadingAnchor.constraint(equalTo: sectionImageView.leadingAnchor, constant: 30),
        titleLabel.trailingAnchor.constraint(equalTo: sectionImageView.trailingAnchor, constant: -30),
        titleLabel.topAnchor.constraint(lessThanOrEqualTo: sectionImageView.topAnchor, constant: 330),
        titleLabel.bottomAnchor.constraint(equalTo: sectionImageView.bottomAnchor, constant: -30),
        
        dimensionBefore.constraint(equalTo: dimensionAfter),
        typeLabel.centerXAnchor.constraint(equalTo: sectionImageView.centerXAnchor),
        
        dividerLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
        dividerLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
        dividerLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        dividerLineView.heightAnchor.constraint(equalToConstant: 1)
        ]
    
        landscape = [
        closeButton.heightAnchor.constraint(equalToConstant: 40),
        closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
        closeButton.widthAnchor.constraint(equalToConstant: 40),
        closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),

        sectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 150),
        sectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -150),
        sectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
        sectionImageView.bottomAnchor.constraint(equalTo: dividerLineView.topAnchor, constant: -65),
        
        titleLabel.leadingAnchor.constraint(equalTo: sectionImageView.leadingAnchor, constant: 30),
        titleLabel.trailingAnchor.constraint(equalTo: sectionImageView.trailingAnchor, constant: -30),
        titleLabel.topAnchor.constraint(lessThanOrEqualTo: sectionImageView.topAnchor, constant: 330),
        titleLabel.bottomAnchor.constraint(equalTo: sectionImageView.bottomAnchor, constant: -30),
        
        dimensionBefore.constraint(equalTo: dimensionAfter),
        typeLabel.centerXAnchor.constraint(equalTo: sectionImageView.centerXAnchor),
        
        dividerLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
        dividerLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
        dividerLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        dividerLineView.heightAnchor.constraint(equalToConstant: 1)
        ]
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        var frame = layoutAttributes.frame
        frame.size.height = ceil(frame.width * 1.45)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
}

extension ThemeImageCell: ConstaintInvalidation {
    func setConstraints(orientation: UIInterfaceOrientation) {
        self.changeAndUpdateConstraints(orientation: orientation)
    }
    
    
}
