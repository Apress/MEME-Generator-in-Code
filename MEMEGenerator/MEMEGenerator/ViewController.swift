//
//  ViewController.swift
//  MEMEGenerator
//
//  Created by Tihomir RAdeff on 1.11.22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [CollectionViewItem] = []
    
    var images = [
        "meme1.jpg",
        "meme2.jpg",
        "meme3.jpg",
        "meme4.jpg",
        "meme5.jpg",
        "meme6.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //add all images into an array of custom items
        for i in images {
            let item = CollectionViewItem()
            item.image = i
            items.append(item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.imageView.image = nil
        cell.tag = indexPath.row
        
        DispatchQueue.global().async {
            let url = Bundle.main.url(forResource: self.items[indexPath.row].image, withExtension: nil)
            let data = NSData(contentsOf: url!)
            let thumbnail = UIImage(data: data! as Data)
            DispatchQueue.main.async {
                if cell.tag == indexPath.row {
                    cell.imageView.image = thumbnail
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3.0 // 3 images per row
        let height = width // make it square
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "OpenEditor", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! EditorController
        destination.image = items[collectionView.indexPathsForSelectedItems![0].row].image
    }
}

