//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/30/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GalleryViewController: BasicContentViewController {
    
    let galleryData: Gallery
    var constraintDelegate: ConstaintInvalidation?
    
    init(galleryData: Gallery) {
        self.galleryData = galleryData
        super.init(nibName: nil, bundle: nil)
        super.themeImage = galleryData.coverImage
        super.themeTitle = galleryData.title
        super.themeType = "Gallery"
        collectionView.register(AnotherGalleryCell.self, forCellWithReuseIdentifier: "anotherGalleryCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        
        if indexPath.section == 0 {
            cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        if indexPath.section > 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "anotherGalleryCell", for: indexPath) as! AnotherGalleryCell
            (cell as! AnotherGalleryCell).imageViewData = galleryData.images[indexPath.section - 1]
            self.constraintDelegate = cell as! AnotherGalleryCell
            for view in cell.contentView.subviews where view is UIImageView {
                let imageView = (view as! UIImageView)
                let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                imageView.addGestureRecognizer(tap)
            }
        }
        return cell
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let galleryItemVC = GalleryItemViewController()
        galleryItemVC.image = (tapGestureRecognizer.view as! UIImageView).image
        galleryItemVC.modalPresentationStyle = .fullScreen
        galleryItemVC.modalTransitionStyle = .crossDissolve
        self.present(galleryItemVC, animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let before = self.view.window?.windowScene?.interfaceOrientation
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            let after = self!.view.window?.windowScene?.interfaceOrientation
            if before != after {
                self!.baseConstraintDelegate?.setConstraints(orientation: after!)
            }
        }
//        coordinator.animate(alongsideTransition: { [self] (context) in
//            guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }
//            constraintDelegate?.setConstraints(orientation: windowInterfaceOrientation)
//            self.view.layoutSubviews()
//        })
        
    }
    
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        galleryData.images.count + 1
    }
    
}
