//
//  AvatarViewController.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import SVProgressHUD

class AvatarViewController: UIViewController {
    
    var status = 1
    var photos = ["body1", "body2", "body3", "body4", "white"]
    //var localImageURL: NSURL?
    var iconRef: StorageReference?
    var iconImage: UIImage?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var beakImageView: UIImageView!
    @IBOutlet weak var cheekImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //collectionView.dataSource = self
        //collectionView.register(UINib(nibName: "AvatarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        iconImageView.image = UIImage(named: "white")
        eyeImageView.image = UIImage(named: "white")
        beakImageView.image = UIImage(named: "white")
        cheekImageView.image = UIImage(named: "white")
        headImageView.image = UIImage(named: "white")

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 105, height: 105)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)


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
        //avatarImageをアイコンに上書き
        iconImage = imageCreate(bodyImage: iconImageView.image!, eyeImage: eyeImageView.image!, beakImage: beakImageView.image!, cheekImage: cheekImageView.image!, headImage: headImageView.image!)
        //self.localImageURL = iconImage.InfoKey.imageURL as? NSURL
        /*let date:Date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd-HH:mm:ss"
        let sDate = format.string(from: date)*/
        let storageref = Storage.storage().reference().child(Const.iconPath).child(Auth.auth().currentUser!.uid + ".jpg")
        let data = iconImage!.jpegData(compressionQuality: 1.0)! as NSData
        storageref.delete()
        storageref.putData(data as Data, metadata: nil) { (data, error) in
                    if error != nil {

                        return
                    }
            self.iconRef = storageref
                }
        
        let postViewController = self.storyboard?.instantiateViewController(withIdentifier: "Post") as! PostViewController
        postViewController.iconImage = iconImage
        
        SVProgressHUD.showSuccess(withStatus: "アイコン画像を変更しました")
        self.dismiss(animated: true, completion: nil)
    }
    
    /*func setIconImage(_ postData: PostData) {
        postData.iconImage = self.iconImage
        print("DEBUG_PRINT: iconImageをpostDataに渡しました")
        return
    }*/


    @IBAction func avarar(_ sefue: UIStoryboardSegue) {
    }


}

extension AvatarViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
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
    
    //セルのサイズを指定する処理
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        //collectionViewLayout.estimatedItemSize = CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 3)
        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 10

        //セルのサイズを指定。画面上にセルを3つ表示させたいのであれば、デバイスの横幅を3分割した横幅　- セル間のスペース*2（セル間のスペースが二つあるため）
        let cellSize:CGFloat = view.bounds.width/3 - horizontalSpace*2

        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // セルがタップされたとき
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            //if (collectionView.cellForItem(at: indexPath) as? UICollectionViewCell?) != nil {
                print("DEBUG_PRINT: セルがタップされました")
                // セルの要素が取得できる
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
