//
//  ViewController.swift
//  pictures
//
//  Created by kudakwashe on 2019/10/12.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit

struct Item {
    var imageName: String
}
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let Number = 4;
    var count = 0;
    
    var items: [Item] = [
        Item(imageName: "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA23476_hires.jpg"),
        Item(imageName: "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA23479_hires.jpg"),
        Item(imageName: "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA23478_hires.jpg"),
        Item(imageName: "https://www.jpl.nasa.gov/spaceimages/images/largesize/PIA23476_hire.jpg")]
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemsPerRow: CGFloat = 2
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 3
            
            let width = (collectionView.frame.width - (numberOfItemsPerRow - 1) * interItemSpacing) / numberOfItemsPerRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            
        }
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        cell.imageLoadingIndicator.startAnimating();
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if count != Number {
            var data2: Data?;
            guard let url = URL(string: items[indexPath.item].imageName) else { return cell }
            DispatchQueue.global(qos:.background).async {
                do {
                    let data = try Data(contentsOf: url)
                    data2 = data
                    DispatchQueue.main.async {
                        cell.imageLoadingIndicator.stopAnimating();
                        if let data = data2, let image = UIImage(data: data) {
                            cell.imageView.image = image;
                            cell.imageLoadingIndicator.stopAnimating();
                            if self.count == 4
                            {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            }
                        }
                    }
                } catch {
                    let alert = UIAlertController(title: "Error", message: "Cannot Access to \(url)", preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                    self.present(alert, animated: true);
                    cell.imageLoadingIndicator.isHidden = true;
                    cell.imageLoadingIndicator.stopAnimating();
                }
            }
            count = count + 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("coming soon")
    }
}
