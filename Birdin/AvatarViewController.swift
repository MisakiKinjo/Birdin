//
//  AvatarViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit

class AvatarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var status = 0
    var photos = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleBodyButton(_ sender: Any) {
        status = 1
        photos = ["body1", "body2", "body3", "body4"]
    }
    
    @IBAction func handleEyeButton(_ sender: Any) {
        status = 2
        photos = ["eye1", "eye2", "eye3", "eye4", "eye5"]
    }
    
    @IBAction func handleBeakButton(_ sender: Any) {
        status = 3
        photos = ["beak1", "beak2", "beak3", "beak4", "beak5", "beak6"]
    }
    
    @IBAction func handleCheekButton(_ sender: Any) {
        status = 4
        photos = ["cheek1", "cheek2"]
    }
    
    @IBAction func handleHeadButton(_ sender: Any) {
        status = 5
        photos = ["hair", "flower"]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num: Int = 0
        if status == 1 {
            num = 4
        }else if status == 2 {
            num = 5
        }else if status == 3 {
            num = 6
        }else if status == 4 {
            num = 2
        }else if status == 5 {
            num = 2
        }
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: photos[indexPath.row])
        imageView.image = cellImage
        return cell
    }

    @IBAction func avarar(_ sefue: UIStoryboardSegue) {
    }


}
