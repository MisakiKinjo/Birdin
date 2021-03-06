//
//  PostTableViewCell.swift
//  Birdin
//
//  Created by 金城美咲 on 2022/04/18.
//

import UIKit
import Firebase
import FirebaseStorageUI
import FirebaseStorage

class PostTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let userIcon = UserIcon.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //iconImageView = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        //画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        //　キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        // いいねボタンの表示
        if postData.isLiked {
            
            let buttonImage = UIImage(systemName: "heart.fill")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(systemName: "heart")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
            // コメントの表示
        var comments = ""
        for comment in postData.comments {
            comments += "\(comment)\n"
        }
            self.commentLabel.text = comments
        
        //アイコンの表示
        /*let date:Date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd-HH:mm:ss"
        let sDate = format.string(from: date)
        iconImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray*/
        let postIconRef = Storage.storage().reference().child(Const.iconPath).child(postData.id + Auth.auth().currentUser!.uid + ".jpg")
        //iconImageView.image = userIcon.icon
        iconImageView.sd_setImage(with: postIconRef)
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width * 0.5
        iconImageView.clipsToBounds = true
        
        //ユーザーネームの表示
        self.nameLabel.text = postData.name
        
        //ボタンの色
        let r = CGFloat.random(in: 0 ... 255) / 255.0
        let g = CGFloat.random(in: 0 ... 255) / 255.0
        let b = CGFloat.random(in: 0 ... 255) / 255.0
        likeButton.tintColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
        commentButton.tintColor = UIColor(red:r, green: g, blue: b, alpha: 1.0)
    }
    
}
