//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/3/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryCell: UICollectionViewCell {
    
    var textViewData: String? {
        didSet {
            textView.text = textViewData
        }
    }
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textAlignment = .left
        textView.font = UIFont(name: "Rockwell-Regular", size: 24)
        textView.textContainer.maximumNumberOfLines = 0
        textView.textColor = .white
        textView.autoresizingMask = .flexibleHeight

        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.white.cgColor

        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextView() {
        self.contentView.addSubview(textView)
        
        textView.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 40)

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        var sizee = textView.sizeThatFits(CGSize(width: frame.size.width, height: size.height))

        sizee.height = textView.intrinsicContentSize.height + textView.contentInset.top + textView.textContainerInset.bottom + textView.textContainerInset.left
        frame.size = sizee
        layoutAttributes.frame = frame

        return layoutAttributes
    }
    
}
