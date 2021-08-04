//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/30/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class BasicContentViewController: UIViewController {
    
    var themeImage: UIImage?
    var themeTitle: String?
    var themeType: String?
    
    var baseConstraintDelegate: ConstaintInvalidation?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = AutoInvalidatingLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
        
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.backgroundColor = .black
        collectionView.register(ThemeImageCell.self, forCellWithReuseIdentifier: "themeImageCell")
        return collectionView
    }()
    
//    var completionHandler: ((String) -> Int)?
    
    override func viewDidLoad() {
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        flowLayout.invalidateLayout()
        
        let before = self.view.window?.windowScene?.interfaceOrientation
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            let after = self!.view.window?.windowScene?.interfaceOrientation
            if before != after {
                self!.baseConstraintDelegate?.setConstraints(orientation: after!)
            }
        }
    }
}

extension BasicContentViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "themeImageCell", for: indexPath) as! ThemeImageCell
        for view in cell.contentView.subviews where view is UIButton {
            let button = (view as! UIButton)
            button.addTarget(self, action: #selector(dismissThis(sender:)), for: .touchUpInside)
        }
        self.baseConstraintDelegate = cell
        cell.imageData = themeImage
        cell.titleData = themeTitle
        cell.typeData = themeType
        return cell

    }
    
    @objc private func dismissThis(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
}
