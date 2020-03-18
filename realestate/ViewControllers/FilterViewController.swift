//
//  FilterViewController.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import UIKit
import DateTimePicker

class FilterViewController: UIViewController {
    @IBOutlet weak var provinceCollectionView: UICollectionView!
    @IBOutlet weak var districtCollectionView: UICollectionView!
    @IBOutlet weak var wardCollectionView: UICollectionView!
    @IBOutlet weak var provinceFilterText: UITextField!
    @IBOutlet weak var typeOfWorkCollectionView: UICollectionView!
    var provinces: [Province] = []
    var filterProvinces: [Province] = [] {
        didSet {
            provinceCollectionView.reloadData()
        }
    }
    
    var districts: [District] = []
    var filterDistricts: [District] = [] {
        didSet {
            districtCollectionView.reloadData()
        }
    }
    
    var wards: [Ward] = [] {
        didSet {
            wardCollectionView.reloadData()
        }
    }
    
    var subjects: [Subject] = [] {
        didSet {
            typeOfWorkCollectionView.reloadData()
        }
    }
    
    var picker: DateTimePicker?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        provinces = DbManagerment.getAllProvince()
        districts = DbManagerment.getAllDistrict()
        subjects = DbManagerment.getAllSubject()
        provinceFilter(self.provinceFilterText as Any)
        
        provinceCollectionView.setEmptyMessage("Can not get data!")
        districtCollectionView.setEmptyMessage("Please pick a city!")
        wardCollectionView.setEmptyMessage("Please pick a district!")
    }
    
    @IBAction func provinceFilter(_ sender: Any) {
        guard let filterText = self.provinceFilterText.text else {
            filterProvinces = provinces
//            provinceCollectionView.reloadData()
            return
        }
        if filterText == "" {
            filterProvinces = provinces
//            provinceCollectionView.reloadData()
            return
        }
        filterProvinces = provinces.filter({$0.name.folding(options: .diacriticInsensitive, locale: .current).contains(filterText.folding(options: .diacriticInsensitive, locale: .current))})
//        provinceCollectionView.reloadData()
    }
    

    @IBAction func exitFilter(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func startDateSelect(_ sender: Any) {
        let min = Date().addingTimeInterval(-60 * 60 * 24 * 4)
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        let yP = self.view.bounds.height - (picker?.frame.size.height ?? 0)
        picker?.frame = CGRect(x: 0, y: yP, width: picker!.frame.size.width, height: picker?.frame.size.height ?? 0)
        picker?.dismissHandler = cancel
        self.view.addSubview(picker!)
    }
    func cancel() {
        picker?.removeFromSuperview()
    }
}
extension FilterViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        switch collectionView {
            case provinceCollectionView:
                count = filterProvinces.count
                provinceCollectionView.showEmptyMessageWhenNoneData(isShow: count != 0)
                break
            case districtCollectionView:
                count = filterDistricts.count
                districtCollectionView.showEmptyMessageWhenNoneData(isShow: count != 0)
                break
            case wardCollectionView:
                count = wards.count
                wardCollectionView.showEmptyMessageWhenNoneData(isShow: count != 0)
                break
            case typeOfWorkCollectionView:
                count = subjects.count
                typeOfWorkCollectionView.showEmptyMessageWhenNoneData(isShow: count != 0)
                break
            default:
                break
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellIdentifier = ""
        var correcsponList: [IBaseSqlModel] = []
        switch collectionView {
            case provinceCollectionView:
                cellIdentifier = "provinceCell"
                correcsponList = filterProvinces
                break
            case districtCollectionView:
                cellIdentifier = "districtCell"
                correcsponList = filterDistricts
                break
            case wardCollectionView:
                cellIdentifier = "wardCell"
                correcsponList = wards
                break
            case typeOfWorkCollectionView:
                cellIdentifier = "subjectCell"
                correcsponList = subjects
        default:
                break
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PillCollectionViewCell
        cell.item = correcsponList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}
extension FilterViewController : PillCellSelectedProtocol {
    func updateList(item: IBaseSqlModel) {
        switch item.hiarche {
        case .province:
            let _ = filterProvinces.map({$0.isSelect = ($0.id == item.id)})
            provinceCollectionView.reloadData()
            filterDistricts = districts.filter({$0.provinceId == item.id})
            districtCollectionView.reloadData()
            wards = []
            wardCollectionView.reloadData()
            break
        case .district:
            let _ = filterDistricts.map({$0.isSelect = ($0.id == item.id)})
            districtCollectionView.reloadData()
            wards = DbManagerment.getWardById(_districtId: item.id)
            wardCollectionView.reloadData()
            break
        case .ward:
            let _ = wards.map({$0.isSelect = ($0.id == item.id)})
            wardCollectionView.reloadData()
            break
        case .subject:
            let _ = subjects.map({$0.isSelect = ($0.id == item.id)})
            typeOfWorkCollectionView.reloadData()
            break
        }
    }
}
extension FilterViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
