//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/29/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class HomeImageCell: UICollectionViewCell {
    
//    var titleData: String? {
//        didSet{
//
//        }
//    }
//
//    var typeData: String? {
//        didSet {
//
//        }
//    }
        
    var data: ContentType? {
        didSet {
            guard let data = data else {
                return
            }
            switch data {
            case .story(let story):
                imageView.image = story.coverImage
                addLabelsWith(title: story.title, subtitle: "Story")
            case .gallery(let gallery):
                imageView.image = gallery.coverImage
                addLabelsWith(title: gallery.title, subtitle: "Gallery")
            }
        }
    }
        
    private let imageView: HomeImageView = {
        let imageView = HomeImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
                
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func addLabelsWith(title: String, subtitle: String) {
        let titleLabel = setupLabel(text: title, size: 16, color: .white)
        let subtitleLabel = setupLabel(text: subtitle, size: 12, color: UIColor(named: "GrayLabelText")!)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -3),
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: imageView.topAnchor, constant: 150),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
            subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -13),
        ])
    }
    
    private func setupLabel(text: String, size: CGFloat, color: UIColor) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Rockwell-Regular", size: size)
        titleLabel.textColor = color
        titleLabel.text = text
        imageView.addSubview(titleLabel)
        
        return titleLabel
    }
    
    
}
