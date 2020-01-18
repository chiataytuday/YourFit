//
//  ClothData.swift
//  size
//
//  Created by dgulinc on 2020/01/08.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import Foundation

//사이트에 길이가 나와있지 않는 것은 0으로 처리한다.
//select.. 그 옷에 적절한 사이즈를 보여주자

var cloth1_size1 = ClothLengthInformation(waist: 1,seat: 3,rise: 2,thigh: 3,hem: 2,outseam: 3, size:"S")
var cloth1_size2 = ClothLengthInformation(waist: 1,seat: 3,rise: 2,thigh: 3,hem: 2,outseam: 3, size:"M")
var cloth1_size3 = ClothLengthInformation(waist: 1,seat: 3,rise: 2,thigh: 3,hem: 2,outseam: 3, size:"L")
var cloth1_size4 = ClothLengthInformation(waist: 1,seat: 3,rise: 2,thigh: 3,hem: 2,outseam: 3, size: "S")
var size1:[ClothLengthInformation] = [cloth1_size1, cloth1_size2, cloth1_size3, cloth1_size4]

var cloth1 = Cloth(model:"Heritage black mannish crop fit",brand:"FATALISM",price:68600,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/947581/0", recommendSize: "S")



