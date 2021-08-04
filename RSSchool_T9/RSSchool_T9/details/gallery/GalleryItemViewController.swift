//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/4/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryItemViewController: UIViewController, UIScrollViewDelegate {
    
    var image: UIImage?
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConstraints()
        
        self.view.addSubview(closeButton)
        self.view.addSubview(photoImageView)
        self.view.addSubview(scrollView)
        
        self.photoImageView.image = image
        
        closeButton.addTarget(self, action: #selector(dismissGalleryItem(sender:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        scrollView.addGestureRecognizer(tap)
                
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        setOrientation()
    }
    
    private func setOrientation() {
        let isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
        } else {
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
        }
    }
    
    @objc private func dismissGalleryItem(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if self.closeButton.isHidden {
            self.closeButton.isHidden = false
        } else {
            self.closeButton.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setOrientation()
        self.view.layoutSubviews()
    }
    
    private func initConstraints() {
        portrait = [
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            
            photoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            photoImageView.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 40),
            photoImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -170),
            
            scrollView.leadingAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        landscape = [
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            
            photoImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 200),
            photoImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -200),
            photoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: photoImageView.safeAreaLayoutGuide.bottomAnchor),
        ]
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        photoImageView
    }
    
}
