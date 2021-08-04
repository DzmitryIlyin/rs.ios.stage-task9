//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/28/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class HomeViewController: UIViewController {
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 30

        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .white
        collectionView.register(HomeImageCell.self, forCellWithReuseIdentifier: "homePhotoCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    
        prepareConstraints()
        
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 50.0, right: 20.0)
        
        let orientation = (UIApplication.shared.windows.first?.windowScene?.interfaceOrientation)!
        changeAndUpdateConstraints(orientation: orientation)
    }
    
    private func prepareConstraints() {
        portrait = [
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo:self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        landscape = [
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo:self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
    }
    
    private func changeAndUpdateConstraints(orientation: UIInterfaceOrientation) {
        if orientation.isPortrait {
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
        } else {
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
        }
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
        
        let before = self.view.window?.windowScene?.interfaceOrientation
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            let after = self!.view.window?.windowScene?.interfaceOrientation
            if before != after {
                self?.changeAndUpdateConstraints(orientation: after!)
                self!.view.layoutIfNeeded()
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsInOneLine: CGFloat = 2
        let width: CGFloat
        if view.bounds.width < view.bounds.height {
            width = view.bounds.width - flowLayout.minimumInteritemSpacing - (collectionView.contentInset.left + collectionView.contentInset.right)
        } else {
            width = view.bounds.width - 4.5 * (collectionView.contentInset.left + collectionView.contentInset.right)
        }
        
        let cellWidth = floor(width / itemsInOneLine)
               
        return CGSize(width: cellWidth, height: cellWidth * 1.2)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        FillingData.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homePhotoCell", for: indexPath) as! HomeImageCell
        let value = FillingData.data[indexPath.row]
//        switch value {
//        case .story(let story):
//            cell.titleData = story.title
//            cell.typeData = "Story"
//        case .gallery(let gallery):
//            cell.titleData = gallery.title
//            cell.typeData = "Gallery"
//        }
        
        cell.data = value
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeImageCell

        if case .story(let story) = cell.data {
            let storyViewController = StoryViewController(storyData: story)
            storyViewController.modalPresentationStyle = .fullScreen
            storyViewController.modalTransitionStyle = .crossDissolve
            self.present(storyViewController, animated: true, completion: nil)
        } else if case .gallery(let gallery) = cell.data {
            let galleryViewController = GalleryViewController(galleryData: gallery)
            galleryViewController.modalPresentationStyle = .fullScreen
            galleryViewController.modalTransitionStyle = .crossDissolve
            self.present(galleryViewController, animated: true, completion: nil)
        }
    }
    
}
