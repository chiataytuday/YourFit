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

var cloth1_size1 = ClothLengthInformation(waist: 38.5,seat: 0,rise: 26.5,thigh: 29,hem: 18,outseam: 92, size:"44(28~29)")
var cloth1_size2 = ClothLengthInformation(waist: 41,seat: 0,rise: 27,thigh: 31,hem: 18.5,outseam: 93, size:"46(30~31)")
var cloth1_size3 = ClothLengthInformation(waist: 42.5,seat: 0,rise: 27.5,thigh: 33,hem: 19,outseam: 94, size:"48(32~33)")
var cloth1_size4 = ClothLengthInformation(waist: 44.5,seat: 0,rise: 28,thigh: 35,hem: 19.5,outseam: 95, size:"50(33~34.5)")
var size1:[ClothLengthInformation] = [cloth1_size1, cloth1_size2, cloth1_size3, cloth1_size4]

var cloth1 = Cloth(model:"Heritage black mannish crop fit",brand:"FATALISM",price:68600,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/947581/0", recommendSize: "S")


var cloth2_size1 = ClothLengthInformation(waist: 38,seat: 0,rise: 23,thigh: 26.75,hem: 16,outseam: 92, size:"44(28~29)")
var cloth2_size2 = ClothLengthInformation(waist: 40.5,seat: 0,rise: 24,thigh: 28,hem: 17,outseam: 93, size:"46(30~31)")
var cloth2_size3 = ClothLengthInformation(waist: 43,seat: 0,rise: 25,thigh: 29.25,hem: 18,outseam: 94, size:"48(32~33)")
var cloth2_size4 = ClothLengthInformation(waist: 46.2,seat: 0,rise: 26,thigh: 30.85,hem: 19.25,outseam: 95.25, size:"50(33~34.5)")
var size2:[ClothLengthInformation] = [cloth2_size1, cloth2_size2, cloth2_size3, cloth2_size4]

var cloth2 = Cloth(model:"Tydi crop jeans",brand:"FATALISM",price:67200,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/621274/0", recommendSize: "M")

var cloth3_size1 = ClothLengthInformation(waist: 39,seat: 0,rise: 27.5,thigh: 29,hem: 18.5,outseam: 102.5, size:"44(28~29)")
var cloth3_size2 = ClothLengthInformation(waist: 41,seat: 0,rise: 28,thigh: 30.5,hem: 19.5,outseam: 103, size:"46(30~31)")
var cloth3_size3 = ClothLengthInformation(waist: 43.5,seat: 0,rise: 29,thigh: 31.5,hem: 20,outseam: 104.5, size:"48(32~33)")
var cloth3_size4 = ClothLengthInformation(waist: 45.5,seat: 0,rise: 30,thigh: 33,hem: 21,outseam: 106, size:"50(33~34.5)")
var size3:[ClothLengthInformation] = [cloth3_size1, cloth3_size2, cloth3_size3, cloth3_size4]

var cloth3 = Cloth(model:"Moderation indigo straight fit",brand:"FATALISM",price:83000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/1159065/0", recommendSize: "M")

var cloth4_size1 = ClothLengthInformation(waist: 38,seat: 0,rise: 27.5,thigh: 27.5,hem: 18,outseam: 93, size:"44(28~29)")
var cloth4_size2 = ClothLengthInformation(waist: 40,seat: 0,rise: 28,thigh: 29,hem: 19,outseam: 93.5, size:"46(30~31)")
var cloth4_size3 = ClothLengthInformation(waist: 42.5,seat: 0,rise: 29,thigh: 30,hem: 19.5,outseam: 95, size:"48(32~33)")
var cloth4_size4 = ClothLengthInformation(waist: 44.5,seat: 0,rise: 30,thigh: 31.5,hem: 20.5,outseam: 96.5, size:"50(33~34.5)")
var size4:[ClothLengthInformation] = [cloth4_size1, cloth4_size2, cloth4_size3, cloth4_size4]

var cloth4 = Cloth(model:"off-white straight fit",brand:"FATALISM",price:86000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/1087572/0", recommendSize: "L")

var cloth5_size1 = ClothLengthInformation(waist: 39,seat: 0,rise: 27.5,thigh: 29,hem: 18.5,outseam: 102.5, size:"44(28~29)")
var cloth5_size2 = ClothLengthInformation(waist: 41,seat: 0,rise: 28,thigh: 30.5,hem: 19.5,outseam: 103, size:"46(30~31)")
var cloth5_size3 = ClothLengthInformation(waist: 43.5,seat: 0,rise: 29,thigh: 31.5,hem: 20,outseam: 104.5, size:"48(32~33)")
var cloth5_size4 = ClothLengthInformation(waist: 45.5,seat: 0,rise: 30,thigh: 33,hem: 21,outseam: 106, size:"50(33~34.5)")
var size5:[ClothLengthInformation] = [cloth5_size1, cloth5_size2, cloth5_size3, cloth5_size4]

var cloth5 = Cloth(model:"Melt black straight fit",brand:"FATALISM",price:89000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/1159066/0", recommendSize: "M")


var cloth6_size1 = ClothLengthInformation(waist: 38.5,seat: 0,rise: 29,thigh: 27.5,hem: 18.5,outseam: 93, size:"44(28~29)")
var cloth6_size2 = ClothLengthInformation(waist: 40,seat: 0,rise: 29.5,thigh: 29,hem: 19,outseam: 94, size:"46(30~31)")
var cloth6_size3 = ClothLengthInformation(waist: 41.5,seat: 0,rise: 30,thigh: 29.5,hem: 19.5,outseam: 95, size:"48(32~33)")
var cloth6_size4 = ClothLengthInformation(waist: 43.5,seat: 0,rise: 30.5,thigh: 30,hem: 20,outseam: 96, size:"50(33~34.5)")
var size6:[ClothLengthInformation] = [cloth6_size1, cloth6_size2, cloth6_size3, cloth6_size4]

var cloth6 = Cloth(model:"eden black wide crop fit",brand:"FATALISM",price:98000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/826750/0", recommendSize: "L")

var cloth7_size1 = ClothLengthInformation(waist: 38.5,seat: 0,rise: 27.5,thigh: 28.5,hem: 19,outseam: 102.5, size:"44(28~29)")
var cloth7_size2 = ClothLengthInformation(waist: 41,seat: 0,rise: 28,thigh: 30,hem: 20,outseam: 103, size:"46(30~31)")
var cloth7_size3 = ClothLengthInformation(waist: 43.5,seat: 0,rise: 29,thigh: 31,hem: 20.5,outseam: 104.5, size:"48(32~33)")
var cloth7_size4 = ClothLengthInformation(waist: 46.7,seat: 0,rise: 30,thigh: 32.5,hem: 21.5,outseam: 106, size:"50(33~34.5)")
var size7:[ClothLengthInformation] = [cloth7_size1, cloth7_size2, cloth7_size3, cloth7_size4]

var cloth7 = Cloth(model:"ruin blue straight fit",brand:"FATALISM",price:89000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/1087578/0", recommendSize: "L")

var cloth8_size1 = ClothLengthInformation(waist: 38,seat: 0,rise: 29.7,thigh: 31.5,hem: 19,outseam: 106, size:"44(28~29)")
var cloth8_size2 = ClothLengthInformation(waist: 40.5,seat: 0,rise: 30.7,thigh: 32.5,hem: 20,outseam: 107, size:"46(30~31)")
var cloth8_size3 = ClothLengthInformation(waist: 43,seat: 0,rise: 31.7,thigh: 33.55,hem: 21,outseam: 108, size:"48(32~33)")
var cloth8_size4 = ClothLengthInformation(waist: 46.2,seat: 0,rise: 32.7,thigh: 35.15,hem: 22.25,outseam: 109, size:"50(33~34.5)")
var size8:[ClothLengthInformation] = [cloth8_size1, cloth8_size2, cloth8_size3, cloth8_size4]

var cloth8 = Cloth(model:"와이드핏 데님진(인디고) MUS-1",brand:"FATALISM",price:39000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/957798/0", recommendSize: "S")

var cloth9_size1 = ClothLengthInformation(waist: 38.5,seat: 0,rise: 27,thigh: 29.25,hem: 18.5,outseam: 93, size:"44(28~29)")
var cloth9_size2 = ClothLengthInformation(waist: 41,seat: 0,rise: 28,thigh: 30.5,hem: 19.5,outseam: 94, size:"46(30~31)")
var cloth9_size3 = ClothLengthInformation(waist: 43.5,seat: 0,rise: 29,thigh: 31.75,hem: 20.5,outseam: 95, size:"48(32~33)")
var cloth9_size4 = ClothLengthInformation(waist: 46.7,seat: 0,rise: 30,thigh: 33.35,hem: 21.75,outseam: 96, size:"50(33~34.5)")
var size9:[ClothLengthInformation] = [cloth9_size1, cloth9_size2, cloth9_size3, cloth9_size4]

var cloth9 = Cloth(model:"Moderation indigo straight crop fit",brand:"FATALISM",price:83000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/1211807/0", recommendSize: "M")

var cloth10_size1 = ClothLengthInformation(waist: 37,seat: 0,rise: 25,thigh: 26,hem: 15,outseam: 94, size:"44(28~29)")
var cloth10_size2 = ClothLengthInformation(waist: 38.5,seat: 0,rise: 26,thigh: 27,hem: 16,outseam: 95.5, size:"46(30~31)")
var cloth10_size3 = ClothLengthInformation(waist: 41,seat: 0,rise: 27,thigh: 28,hem: 16.5,outseam: 97, size:"48(32~33)")
var cloth10_size4 = ClothLengthInformation(waist: 43.5,seat: 0,rise: 28,thigh: 29,hem: 18,outseam: 98, size:"50(33~34.5)")
var size10:[ClothLengthInformation] = [cloth10_size1, cloth10_size2, cloth10_size3, cloth10_size4]

var cloth10 = Cloth(model:"Dude blue washed crop jeans",brand:"FATALISM",price:89000,clothImage: #imageLiteral(resourceName: "cl23"),url:"https://store.musinsa.com/app/product/detail/684820/0", recommendSize: "M")
