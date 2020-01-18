//
//  cloth.swift
//  size
//
//  Created by dgulinc on 2020/01/08.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import Foundation
import UIKit


struct ClothLengthInformation{
    var waist:Double    //허리
    var seat:Double     //힙
    var rise:Double     //밑위
    var thigh:Double    //허벅지
    var hem:Double      //밑단
    var outseam:Double  //총장
    var size:String     //사이트 내 사이즈
}


//사이트 옷의 정보
class Cloth {
    var model:String
    var brand:String
    var price:Int
    var clothImage:UIImage
    var url:String
    var recommendSize:String
    
    
    init(model:String, brand:String, price:Int, clothImage:UIImage, url:String, recommendSize:String){
        self.model=model
        self.brand=brand
        self.price=price
        self.clothImage=clothImage
        self.url = url
        self.recommendSize = recommendSize
    }
    
}

//user가 측정한 사이즈
class MyClothSize {
    var size:[ClothLengthInformation]
    init(size:[ClothLengthInformation]) {
        self.size = size
    }
}



// 비교 함수 생성하기
func size(size:[ClothLengthInformation])->String{
    return "S"
}

struct Liked {
    // Singleton
    static var shared = Liked()
    
    var saves : [Cloth] = []
    
    func isLiked(_ item: Cloth) -> Bool {
        for one in saves {
            // 제품 이름으로 같다고 비교한다. TODO : equal operator 작성
            if one.model == item.model{
                return true
            }
        }
        return false
    }
    
    mutating func add(_ item: Cloth) {
        self.saves.append(item)
    }
    
    mutating func remove(_ item: Cloth) {
        for (index, one) in saves.enumerated() {
            // 제품 이름으로 같다고 비교한다. TODO : equal operator 작성
            if one.model == item.model {
                saves.remove(at: index)
                return
            }
        }
    }
}
