//
//  ViewController.swift
//  size
//
//  Created by dgulinc on 2020/01/08.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource {

    var result = Int64() {
        didSet {
            DispatchQueue.main.async {
                if self.result != 0 {
                    self.recommendLabelz.text = "\(self.result)로 검색한 결과 입니다."
                    self.SizeChooseLabel.text = "다른 옷 사이즈로 검색하기"
                }
                else {
                    self.recommendLabelz.text = "사이즈를 입력하시면 추천 사이즈를 확인하실 수 있습니다."
                    self.SizeChooseLabel.text = "사이즈 검색하기"
                }
                self.addFittering()
                self.clothTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var SizeChooseLabel: UILabel!
    
//    @IBAction func sizeChooseButton(_ sender: Any) {
//        if let tab = self.navigationController?.tabBarController {
//            tab.selectedIndex = 1
//        }
//    }

    func readDataFromCSV(fileName:String, fileType: String)-> String!{
                  guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
                      else {
                          return nil
                  }
                  do {
                      var contents = try String(contentsOfFile: filepath, encoding: .utf8)
                      contents = cleanRows(file: contents)
                      return contents
                  } catch {
                      print("File Read Error for file \(filepath)")
                      return nil
                  }
              }

      

          func cleanRows(file:String)->String{
              var cleanFile = file
              cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
              cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
              //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
              //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
              return cleanFile
          }
          
          func csv(data: String) -> [[String]] {
              var result: [[String]] = []
              let rows = data.components(separatedBy: "\n")
              for row in rows {
                  let columns = row.components(separatedBy: ",")
                  result.append(columns)
              }
              return result
          }
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return ClothMenu.count
    }
    
    func addFittering()->Void{
           var data = readDataFromCSV(fileName: "latestdata", fileType: ".csv")
                           data = cleanRows(file: data!)
                           let csvRows = csv(data: data!)
                           for i in 1...79 {
                            //입력된 사이즈가 없을 때
                            if result == 0 {
                                if csvRows[i][5] != csvRows[i-1][5]{
                                    ClothMenu.append(Cloth(model: csvRows[i][10], brand: csvRows[i][6], price: csvRows[i][7], discountRate: csvRows[i][8], realPrice: csvRows[i][9],clothImage: #imageLiteral(resourceName: "Image"), modelDetail: csvRows[i][5], url: "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no="+csvRows[i][5], recommendSize: "0"))
                                }
                                
                            }
                            //입력된 사이즈가 있을 때
                            else if Int64(csvRows[i][0]) == self.result{
                                    ClothMenu.append(Cloth(model: csvRows[i][10], brand: csvRows[i][6], price: csvRows[i][7], discountRate: csvRows[i][8], realPrice: csvRows[i][9], clothImage: #imageLiteral(resourceName: "Image"), modelDetail: csvRows[i][5], url: "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no="+csvRows[i][5], recommendSize: csvRows[i][0]))
//                                var cl = Clothes()
                               }
           }
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClothInformationCell", for: indexPath) as! ClothInformationCell
        let rowData = self.ClothMenu[indexPath.row]
        cell.model.text = "상품명 : " + rowData.model
        cell.brand.text = "브랜드 : " + rowData.brand
        cell.price.text = "가격 : " + rowData.price + "원"
        cell.discountRate.text = rowData.discountRate + "%"
        cell.realPrice.text = "할인가 : " + rowData.realPrice + "원"
        //cell.imageee.image = rowData.clothImage
        return cell
    }

    @IBOutlet weak var recommendLabelz: UILabel!
    
    @IBAction func fromVC3ToVC1 (segue : UIStoryboardSegue) {}
    
    @IBOutlet weak var clothTableView: UITableView!
    var ClothMenu:[Cloth] = []
    
    override func viewDidLoad() {
        
        addFittering()
        super.viewDidLoad()
        clothTableView.dataSource = self
        clothTableView.delegate = self
        
        if self.result != 0 {
            self.recommendLabelz.text = "\(self.result)로 검색한 결과 입니다."
            self.SizeChooseLabel.text = "다른 옷 사이즈로 검색하기"
        }
        else {
            self.recommendLabelz.text = "사이즈를 입력하시면 추천 사이즈를 확인하실 수 있습니다."
            self.SizeChooseLabel.text = "사이즈 검색하기"
        }
        
        //let sizeInformation = ClothLengthInformation(waist: waistSize, thigh: thighSize, hem: hemSize, outseam: outseamSize, size: "S")
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clothDetail" {
            let menu = sender as? Cloth
            if menu != nil {
                let detailController = segue.destination as? ClothDetailViewController
                if detailController != nil {
                    detailController!.clothDetail = menu

                }
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
         self.clothTableView.reloadData()
     }
   
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           performSegue(withIdentifier: "clothDetail", sender: self.ClothMenu[indexPath.row])
       }
}
