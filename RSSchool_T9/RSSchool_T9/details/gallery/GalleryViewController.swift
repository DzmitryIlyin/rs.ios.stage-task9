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
    
    init(galleryData: Gallery) {
        self.galleryData = galleryData
        super.init(nibName: nil, bundle: nil)
        super.themeImage = galleryData.coverImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        if indexPath.section == 0 {
            cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        }
        
        return cell
    }
    
}
