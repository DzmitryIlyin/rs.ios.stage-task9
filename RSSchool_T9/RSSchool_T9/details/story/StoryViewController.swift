//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/30/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit


class StoryViewController: BasicContentViewController {
    
    let storyData: Story
    var invalidationDelegate: InvalidationDelegate?
        
    init(storyData: Story) {
        self.storyData = storyData
        super.init(nibName: nil, bundle: nil)
        super.themeImage = storyData.coverImage
        super.themeTitle = storyData.title
        super.themeType = "Story"
        collectionView.register(DrawingCell.self, forCellWithReuseIdentifier: "drawningCell")
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: "storyCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        
        if indexPath.section == 0 {
            cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawningCell", for: indexPath) as! DrawingCell
            self.invalidationDelegate = (cell as! DrawingCell)
            (cell as! DrawingCell).cellData = storyData
        }
        
        if indexPath.section == 2 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCell
            (cell as! StoryCell).textViewData = storyData.text
        }
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        invalidationDelegate?.invalidateCells()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
}


