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
        collectionView.register(HomePhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        return collectionView
    }()
    

    override func viewDidLoad() {
        
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo:self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 50.0, right: 20.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsInOneLine: CGFloat = 2
        let width = view.bounds.width - flowLayout.minimumInteritemSpacing - (collectionView.contentInset.left + collectionView.contentInset.right)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! HomePhotoCell
        let value = FillingData.data[indexPath.item]
        cell.data = value
//        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomePhotoCell

        switch cell.data {
        case .story(let story):
            let storyViewController = StoryViewController(storyData: story)
            self.present(storyViewController, animated: true, completion: nil)
        case .gallery(let gallery):
            let galleryViewController = GalleryViewController(galleryData: gallery)
            self.present(galleryViewController, animated: true, completion: nil)
        case .none:
            print("none")
        }
    }
    
}
