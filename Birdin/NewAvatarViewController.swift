//
//  NewAvatarViewController.swift
//  Birdin
//
//  Created by éåįžå˛ on 2022/04/18.
//

import UIKit
import Firebase
import SVProgressHUD

class NewAvatarViewController: UIViewController {
    
    var status = 1
    var photos = ["body1", "body2", "body3", "body4", "white"]
    let userIcon = UserIcon.shared

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var beakImageView: UIImageView!
    @IBOutlet weak var cheekImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //collectionView.register(UINib(nibName: "NewAvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")

        iconImageView.image = UIImage(named: "white")
        eyeImageView.image = UIImage(named: "white")
        beakImageView.image = UIImage(named: "white")
        cheekImageView.image = UIImage(named: "white")
        headImageView.image = UIImage(named: "white")
    }
    
    @IBAction func handleBodyButton(_ sender: Any) {
        status = 1
        photos = ["body1", "body2", "body3", "body4", "white"]
        self.collectionView.reloadData()
    }
    
    @IBAction func handleEyeButton(_ sender: Any) {
        status = 2
        photos = ["eye1", "eye2", "eye3", "eye4", "eye5", "white"]
        self.collectionView.reloadData()
    }
    
    @IBAction func handleBeakButton(_ sender: Any) {
        status = 3
        photos = ["beak1", "beak2", "beak3", "beak4", "beak5", "beak6", "white"]
        self.collectionView.reloadData()
    }
    
    @IBAction func handleCheekButton(_ sender: Any) {
        status = 4
        photos = ["cheek1", "cheek2", "white"]
        self.collectionView.reloadData()
    }
    
    @IBAction func handleHeadButton(_ sender: Any) {
        status = 5
        photos = ["hair", "flower", "white"]
        self.collectionView.reloadData()
    }
    
    func imageCreate(bodyImage: UIImage, eyeImage: UIImage, beakImage: UIImage, cheekImage: UIImage, headImage: UIImage) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 200, height: 200), false, 0)
        
        let rect1 = CGRect(x: 0, y: 0, width: 200, height: 200)
        bodyImage.draw(in: rect1)
        
        let rect2 = CGRect(x: 0, y: 0, width: 200, height: 200)
        eyeImage.draw(in: rect2)
        
        let rect3 = CGRect(x:0, y:0, width: 200, height: 200)
        beakImage.draw(in: rect3)
        
        let rect4 = CGRect(x:0, y:0, width: 200, height: 200)
        cheekImage.draw(in: rect4)
        
        let rect5 = CGRect(x:0, y:0, width: 200, height: 200)
        headImage.draw(in: rect5)
        
        let avatarImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return avatarImage!
        
    }
    
    @IBAction func handleFinishButton(_ sender: Any) {
        
        let iconImage = imageCreate(bodyImage: iconImageView.image!, eyeImage: eyeImageView.image!, beakImage: beakImageView.image!, cheekImage: cheekImageView.image!, headImage: headImageView.image!)
        /*let storageref = Storage.storage().reference().child(Const.iconPath).child(Auth.auth().currentUser!.uid + ".jpg")
        let data = iconImage.jpegData(compressionQuality: 1.0)! as NSData
        storageref.putData(data as Data, metadata: nil) { (data, error) in
                    if error != nil {

                        return
                    }
            //self.iconRef = storageref
                }*/
        /*let newNameViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewName") as! NewNameViewController
        newNameViewController.image = iconImage*/
        userIcon.icon = iconImage
        
        //SVProgressHUD.showSuccess(withStatus: "ãĸã¤ãŗãŗįģåãįģé˛ããžãã")
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func newAvatar(_ sefue: UIStoryboardSegue) {
    }

    

}


extension NewAvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num: Int = 0
        if status == 1 {
            num = 5
        }else if status == 2 {
            num = 6
        }else if status == 3 {
            num = 7
        }else if status == 4 {
            num = 3
        }else if status == 5 {
            num = 3
        }
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        let imageView = collectionCell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: photos[indexPath.row])
        imageView.image = cellImage
        return collectionCell
    }
    
    //ãģãĢãŽãĩã¤ãēãæåŽããåĻį
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // æ¨ĒæšåãŽãšããŧãščĒŋæ´
        let horizontalSpace:CGFloat = 10

        //ãģãĢãŽãĩã¤ãēãæåŽãįģéĸä¸ãĢãģãĢã3ã¤čĄ¨į¤ēãããããŽã§ããã°ãããã¤ãšãŽæ¨Ēåšã3åå˛ããæ¨Ēåšã- ãģãĢéãŽãšããŧãš*2īŧãģãĢéãŽãšããŧãšãäēã¤ããããīŧ
        let cellSize:CGFloat = view.bounds.width/3 - horizontalSpace*2

        // æ­ŖæšåŊĸã§čŋããããĢwidth,heightãåããĢãã
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // ãģãĢããŋãããããã¨ã
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            //if (collectionView.cellForItem(at: indexPath) as? UICollectionViewCell?) != nil {
                print("DEBUG_PRINT: ãģãĢããŋãããããžãã")
                // ãģãĢãŽčĻį´ ãååžã§ãã
                let collectionCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
                let cellImage = UIImage(named: photos[indexPath.row])
                let imageView = collectionCell.contentView.viewWithTag(1) as! UIImageView
                imageView.image = cellImage
            if status == 1 {
                iconImageView.image = imageView.image
                self.collectionView.reloadData()
            }else if status == 2 {
                eyeImageView.image = imageView.image
                self.collectionView.reloadData()
            }else if status == 3 {
                beakImageView.image = imageView.image
                self.collectionView.reloadData()
            }else if status == 4 {
                cheekImageView.image = imageView.image
                self.collectionView.reloadData()
            }else if status == 5 {
                headImageView.image = imageView.image
                self.collectionView.reloadData()
            }
            //}
        }
    
}
