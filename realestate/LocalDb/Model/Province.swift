//
//  Province.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 2/27/20.
//  Copyright © 2020 Nguyen Quy Trung. All rights reserved.
//

import Foundation
class Province : BaseSqlModel {
    init(id: Int, name: String, type: String) {
        super.init(id: id, name: name, type: type, hiarche: .province)
    }
}
