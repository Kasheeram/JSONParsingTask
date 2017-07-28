//
//  ViewController.swift
//  JSONParsingTask1
//
//  Created by vinay on 10/01/17.
//  Copyright © 2017 CodeYeti. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
   
    var searchURL = "http://newton.montageinnovations.com/api/cashless/orders?userid=6"
    
    var selected = -1
    var ObjectArray = [AnyObject]()
    var sectionCheck:[Bool] = []
   // var count:Int = -1
   // var countDic = [Int:Int]()
    var check:[Bool] = []
    var state:Bool = false
    
    
    var ResultArray = [[AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource=self
        self.tableView.delegate=self
        
        callAlamo(url:searchURL)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func callAlamo(url:String)
    {
        Alamofire.request(url).responseJSON(completionHandler: { response in
            self.parseData(JSONData:response.data!)
        })
    }
    
    func parseData(JSONData:Data)
    {
        do{
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .allowFragments) as! NSArray
            print(readableJSON)
            
            for i in 0..<readableJSON.count
            {
                let arr = readableJSON[i] as! NSArray
                //print(arr.count)
                for i in 0..<arr.count
                {
                    if i == 0
                    {
                        let object = arr[i] as! [String:AnyObject]
                        var tempDict:[String:Any] = [:]
                        tempDict["machineid"] = object["machineid"] as! String
                        
                    
                        self.ObjectArray.append(tempDict as AnyObject)
                    }
                    else
                    {
                        let arrayNext = arr[i] as! NSArray
                        
//                        print("===============================")
//                        print(arrayNext)
//                        print("===============================")
                        
                        var ResultData = [AnyObject]()
                        for i in 0..<arrayNext.count
                        {
                            let obj2 = arrayNext[i] as! [String:AnyObject]
                            var tempDict2:[String:Any] = [:]
                            tempDict2["orderid"] = obj2["orderid"] as! String
                            tempDict2["productname"] = obj2["productname"] as! String
                            tempDict2["unitprice"] = obj2["unitprice"] as! String
                            tempDict2["quantity"] = obj2["quantity"] as! Int
                            tempDict2["total"] = obj2["total"] as! String
                            ResultData.append(tempDict2 as AnyObject)
                          
                        }
                        self.ResultArray.append(ResultData)
                        self.sectionCheck.append(false)
                        self.check.append(false)
                      
                    }
                }
                
            }
                        self.tableView.reloadData()
        }
        catch{
            print(error)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return ResultArray.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ResultArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionCheck[indexPath.section] {
            return 160
        } else {
            return 0
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JSON_TableViewCell
        
       // let data = ResultArray[indexPath.section][indexPath.row] as AnyObject
            cell.orderID.text = ResultArray[indexPath.section][indexPath.row]["orderid"] as? String
            cell.productName.text = ResultArray[indexPath.section][indexPath.row]["productname"] as? String
            cell.unitPrice.text = ResultArray[indexPath.section][indexPath.row]["unitprice"] as? String
            cell.quantity.text = ResultArray[indexPath.section][indexPath.row]["quantity"] as? String
            cell.total.text = ResultArray[indexPath.section][indexPath.row]["total"] as? String
            //check[indexPath.section] = false
        
        return cell
    }
    
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let frame: CGRect = tableView.frame
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0,width: frame.size.width, height:50))
        let headerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0,width: frame.size.width,height: 50))
        headerButton.setTitle(ObjectArray[section]["machineid"] as? String, for: .normal)
        headerButton.setTitleColor(UIColor.red, for: .normal)
        headerButton.backgroundColor = UIColor.yellow
       // headerButton.contentHorizontalAlignment = .left
       
        
        
        headerButton.titleEdgeInsets.left = -UIScreen.main.bounds.width+110
       // headerButton.setImage(UIImage(named: "drop_up"), for: UIControlState.normal)
       // headerButton.setImage(UIImage(named: "drop_down"), for: UIControlState.selected)
        headerButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 300, bottom: 0, right: 5)
        headerButton.imageView?.contentMode = .scaleAspectFit
        
        headerButton.tag = section
        headerButton.addTarget(self, action: #selector(ViewController.buttonTapped(sender:)), for: .touchUpInside)
        headerView.addSubview(headerButton)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func buttonTapped(sender: UIButton) {
     //!sectionCheck[sender.tag]
       
        if selected >= 0
        {
            if selected == sender.tag && state == true
            {
                sectionCheck[selected] = false
                state = false
             }
            else
            {
               sectionCheck[selected] = false
               sectionCheck[sender.tag] = true
               state = true
            }
        }
        else
        {
            sectionCheck[sender.tag] = !sectionCheck[sender.tag]
            state = true
        }
        
        
        
        
        if sender.isSelected
        {
            sender.setImage(UIImage(named: "drop_up"), for: UIControlState.normal)
            sender.isSelected=false
            
        }
        else
        {
            sender.setImage(UIImage(named:"drop_down"), for: UIControlState.selected)
            sender.isSelected=true
        }
       
        
        print(sender.isSelected)
        selected = sender.tag
        tableView.reloadData()
    }

}

