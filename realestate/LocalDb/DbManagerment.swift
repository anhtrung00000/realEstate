//
//  DbManagerment.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
import SQLite
class DbManagerment {
    private class func open(_ dbPath: String = "") -> Connection? {
        guard let databasePath = Bundle.main.path(forResource: "dvhcvn", ofType: "db") else {
            return nil
        }
        guard let db = try? Connection(databasePath) else {
                return nil
        }
        return db
    }
    class func getAllProvince() -> [Province] {
        guard let db = open() else {
            return []
        }
        let provinces = Table("province")
        guard let lstProv = try? db.prepare(provinces) else {
            return []
        }
        
        let id = Expression<Int>("id")
        let name = Expression<String?>("name")
        let type = Expression<String>("type")
        var result = [Province]()
        for prov in lstProv {
            guard let id = try? prov.get(id),
                    let name = try? prov.get(name),
                    let type = try? prov.get(type)
                else {
                continue
            }
            let province = Province(id: id, name: name, type: type)
            result.append(province)
        }
        return result
    }
    class func getAllDistrict() -> [District] {
        guard let db = open() else {
            return []
        }
        let districtes = Table("district")
        guard let lstDistr = try? db.prepare(districtes) else {
            return []
        }
        
        let id = Expression<Int>("id")
        let name = Expression<String?>("name")
        let type = Expression<String>("type")
        let provinceId = Expression<Int>("province_id")
        var result = [District]()
        for dis in lstDistr {
            guard let id = try? dis.get(id),
                    let name = try? dis.get(name),
                    let type = try? dis.get(type),
                    let provinceId = try? dis.get(provinceId)
                else {
                continue
            }
            let district = District(id: id, name: name, type: type, provinceId: provinceId)
            result.append(district)
        }
        return result
    }
    class func getWardById(_districtId: Int) -> [Ward] {
        guard let db = open() else {
            return []
        }
        
        let id = Expression<Int>("id")
        let name = Expression<String?>("name")
        let type = Expression<String>("type")
        let districtId = Expression<Int>("district_id")
        
        let wards = Table("ward")
        let query = wards.where(districtId == _districtId)
        guard let lstWard = try? db.prepare(query) else {
            return []
        }
        
        var result = [Ward]()
        for ward in lstWard {
            guard let id = try? ward.get(id),
                    let name = try? ward.get(name),
                    let type = try? ward.get(type),
                    let districtId = try? ward.get(districtId)
                else {
                continue
            }
            let war = Ward(id: id, name: name, type: type, districtId: districtId)
            result.append(war)
        }
        return result
    }
    class func getAllSubject() -> [Subject] {
        guard let db = open() else {
            return []
        }
        let subjects = Table("subjects")
        guard let lstSub = try? db.prepare(subjects) else {
            return []
        }
        
        let id = Expression<Int>("id")
        let name = Expression<String?>("name")
//        let type = Expression<String>("type")
        var result = [Subject]()
        for sub in lstSub {
            guard let id = try? sub.get(id),
                    let name = try? sub.get(name)
//                    let type = try? sub.get(type)
                else {
                continue
            }
            let subject = Subject(id: id, name: name)
            result.append(subject)
        }
        return result
    }

}
