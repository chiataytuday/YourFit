//
//  LikeViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/15.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit
import RealmSwift


//함수 생성해서 Result<Clothes> 이거 써야 하나 . . . . . .. ..ㅠㅠㅠㅠㅠㅠㅠㅠ

class LikeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var likeClothes : Results<Clothes>?
    //Realm에 저장된 데이터를 가져옵니다.
    let realm = try? Realm()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if likeClothes?.count == 0 {
            tableView.setEmptyView(title: "아직 좋아요를 누른 상품이 없습니다.", message: "원하는 옷을 좋아요 목록에 .... 아 멘트 뭐라하지", messageImage: #imageLiteral(resourceName: "2001991022"))
            return 0
        }
        else {
            tableView.restore()
        }
        return likeClothes!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTableViewCell", for: indexPath) as! LikeTableViewCell
        
        if let db = likeClothes?[indexPath.row]{
            cell.brandLabel.text = db.brand
            cell.modelLabel.text = db.model
            cell.priceLabel.text = "정상가 : " + db.price + "원"
            if db.recommendSize == "0" {
                cell.recommendSizeLabel.text = "사이즈를 입력하시면 추천 사이즈로 추가하실 수 있습니다."
            }
            else {
                cell.recommendSizeLabel.text = "추천 사이즈 : " + db.recommendSize
            }
            
        }
        
        return cell
    }
    
    @IBOutlet weak var likeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeTableView.dataSource = self
        likeTableView.delegate = self
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likeDetail" {
            if let menu = sender as? Clothes {
                let detailController = segue.destination as? ClothDetailViewController
                if detailController != nil {
                    detailController!.clothesDetail = menu
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = likeClothes?[indexPath.row]
        
        performSegue(withIdentifier: "likeDetail", sender: data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        likeClothes = realm?.objects(Clothes.self)  //.sorted(byKeyPath: "recommendSize", ascending: true)
        self.likeTableView.reloadData()
    }
}

extension UITableView {
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
            
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        
    }
    
}
