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
