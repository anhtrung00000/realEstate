//
//  ViewController.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 10/9/19.
//  Copyright © 2019 Nguyen Quy Trung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trungnguyen", for: indexPath) as! DashboardTableViewCell
        cell.place.text = "hanoi"
        cell.roomImage.image = #imageLiteral(resourceName: "Room1")
        cell.roomNam.text = "phong dep"
        cell.roomPrice.text = "$123,45"
        if (indexPath.row != 0)
        {
            cell.like?.isHidden = true
            cell.borderView?.isHidden = true
        }
        return cell
    }
    

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var updownImg: UIImageView!
    @IBOutlet weak var listRooms: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        filterView.layer.cornerRadius = filterView.frame.height/2
        let ime = #imageLiteral(resourceName: "Updown").withRenderingMode(.alwaysTemplate)
        updownImg.image = ime
        updownImg.tintColor = #colorLiteral(red: 0.04500000179, green: 0.5249999762, blue: 0.3610000014, alpha: 1)
        listRooms.rowHeight = UITableView.automaticDimension
        listRooms.estimatedRowHeight = 300
        listRooms.showsVerticalScrollIndicator = false
        let att = NSMutableAttributedString(string: "New York", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 30)])
        let usAtt = NSAttributedString(string: ", US", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 30)])
        att.append(usAtt)
        titleLabel.attributedText = att
    }


}


