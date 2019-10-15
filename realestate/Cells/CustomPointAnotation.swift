//
//  CustomPointAnotation.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 10/11/19.
//  Copyright © 2019 Nguyen Quy Trung. All rights reserved.
//

import Foundation
import MapKit

class CustomPointAnotation: MKPointAnnotation {
    var backgroundColor : UIColor!
    var image : String!
    var textColor : UIColor!
}

class MyAnnotation : NSObject, MKAnnotation{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let isChoosen : Bool
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, isChoosen : Bool = false) {
      self.title = title
      self.locationName = locationName
      self.discipline = discipline
      self.coordinate = coordinate
      self.isChoosen = isChoosen
      super.init()
    }
    
    var subtitle: String? {
      return locationName
    }
    
    var markerTintColor: UIColor  {
      switch discipline {
      case "Monument":
        return .red
      case "Mural":
        return .cyan
      case "Plaque":
        return .blue
      case "Sculpture":
        return .purple
      default:
        return .green
      }
    }
    
}
