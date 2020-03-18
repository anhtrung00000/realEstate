//
//  BaseSqlModel.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
protocol IBaseSqlModel {
    var id: Int { get set }
    var name: String {get set}
    var type: String {get set}
    var hiarche: PositionType {get set}
    var isSelect: Bool {get set}
}
class BaseSqlModel : IBaseSqlModel {
    var hiarche: PositionType
    
    var id: Int
    
    var name: String
    
    var type: String
    
    var isSelect: Bool = false
    
    init(id: Int, name: String, type: String, hiarche: PositionType) {
        self.id = id
        self.name = name
        self.type = type
        self.hiarche = hiarche
    }
    
}
