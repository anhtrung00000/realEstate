//
//  MapViewController.swift
//  realestate
//
//  Created by Nguyen Quy Trung on 10/10/19.
//  Copyright © 2019 Nguyen Quy Trung. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "truannuyen", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 150)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //Stop scroll view sliding
        targetContentOffset.pointee = scrollView.contentOffset
        let indexPath = IndexPath(row: self.indexOfMajorCell(), section: 0)
        roomCollectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = roomCollectionViewLayout.itemSize.width
        let propertionalOffset = roomCollectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(propertionalOffset))
        let safeIndex = max(0, min(9, index))
        return safeIndex
    }
    
    @IBOutlet weak var roomCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var backBtn: CustomUIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var customDrawTf: CustomUITextFeild!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 21.0353972, longitude: 105.7764959)
        centerMapOnLocation(location: initialLocation)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.register(ArtworkView.self,
        forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let artwork = MyAnnotation(title: "trungnnnngngn",
        locationName: "Waikiki Gateway Park",
        discipline: "$123,456",
        coordinate: initialLocation.coordinate, isChoosen: true)
        mapView.addAnnotation(artwork)
        
        let artwork1 = MyAnnotation(title: "King David Kalakaua",
        locationName: "Waikiki Gateway Park",
        discipline: "$123.122",
        coordinate: CLLocationCoordinate2D(latitude: 21.0302715, longitude: 105.7792945))
        mapView.addAnnotation(artwork1)

        let artwork2 = MyAnnotation(title: "King David Kalakaua",
        locationName: "Waikiki Gateway Park",
        discipline: "$123456",
        coordinate: CLLocationCoordinate2D(latitude: 21.033517, longitude: 105.779387))
        mapView.addAnnotation(artwork2)
    }
    
    
    
    
    let regionRadius : CLLocationDistance = 1000
    func centerMapOnLocation(location : CLLocation) {
        let cordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(cordinateRegion, animated: true)
    }
    @IBAction func backBtnPress(_ sender: Any) { navigationController?.popViewController(animated: true)
    }
    
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "blue")
            annotationView!.canShowCallout = true;
            annotationView!.image = UIImage(named: "blue")
        } else {
            //handle blue view re-use...
            annotationView!.annotation = annotation
        }

        //move return to after the if-else...
        return annotationView
    }
}


class ArtworkView: MKAnnotationView {
      override var annotation: MKAnnotation? {
        didSet {
            let artwork = annotation as? MyAnnotation
            if artwork != nil {
                image = configureView(with : artwork?.discipline ?? "fail", when: artwork?.isChoosen ?? false).asImage()
        }
        }
      }
    
    func configureView(with text : String, when choose : Bool) -> UIView{
        
        let height : CGFloat = 50
        let fontSize : CGFloat = 13
        let attribute = [NSAttributedString.Key.foregroundColor : UIColor(named: "Green"), NSMutableAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: fontSize)]
        let nSString = NSAttributedString(string: text, attributes: attribute as [NSAttributedString.Key : Any])
        
        let width = nSString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, context: nil).width + 10
        
        let balloon = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        balloon.backgroundColor = UIColor.clear
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath()
        rectanglePath.move(to: CGPoint(x: width * 65.61 / 200, y: -0))
        rectanglePath.addLine(to: CGPoint(x: width * 123.57 / 200, y: -0))
        rectanglePath.addCurve(to: CGPoint(x: width * 167.44 / 200, y: height * 3.27 / 120), controlPoint1: CGPoint(x: width * 146.51 / 200, y: -0), controlPoint2: CGPoint(x: width * 157.52 / 200, y: -0))
        rectanglePath.addLine(to: CGPoint(x: width * 169.36 / 200, y: height * 3.75 / 120))
        rectanglePath.addCurve(to: CGPoint(x: width, y: height * 47.5 / 120), controlPoint1: CGPoint(x: width * 187.76 / 200, y: height * 10.44 / 120), controlPoint2: CGPoint(x: width, y: height * 27.93 / 120))
        rectanglePath.addCurve(to: CGPoint(x: width, y: height * 50 / 120), controlPoint1: CGPoint(x: width, y: height * 50 / 120), controlPoint2: CGPoint(x: width, y: height * 50 / 120))
        rectanglePath.addLine(to: CGPoint(x: width, y: height * 50 / 120))
        rectanglePath.addLine(to: CGPoint(x: width, y: height * 50 / 120))
        rectanglePath.addLine(to: CGPoint(x: width, y: height * 52.5 / 120))
        rectanglePath.addCurve(to: CGPoint(x: width * 169.36 / 200, y: height * 96.25 / 120), controlPoint1: CGPoint(x: width, y: height * 72.07 / 120), controlPoint2: CGPoint(x: width * 187.76 / 200, y: height * 89.56 / 120))
        rectanglePath.addCurve(to: CGPoint(x: width * 115 / 200, y: height * 100 / 120), controlPoint1: CGPoint(x: width * 157.52 / 200, y: height * 100 / 120), controlPoint2: CGPoint(x: width * 122 / 200, y: height * 97 / 120))
        rectanglePath.addCurve(to: CGPoint(x: width * 100 / 200, y: height), controlPoint1: CGPoint(x: width * 108 / 200, y: height * 103 / 120), controlPoint2: CGPoint(x: width / 2, y: height))
        rectanglePath.addCurve(to: CGPoint(x: width * 85 / 200, y: height * 100 / 120), controlPoint1: CGPoint(x: width * 100 / 200, y: height * 120 / 120), controlPoint2: CGPoint(x: width * 92 / 200, y: height * 103 / 120))
        rectanglePath.addCurve(to: CGPoint(x: width * 32.56 / 200, y: height * 96.73 / 120), controlPoint1: CGPoint(x: width * 78 / 200, y: height * 97 / 120), controlPoint2: CGPoint(x: width * 42.48 / 200, y: height * 100 / 120))
        rectanglePath.addLine(to: CGPoint(x: calWidth(wid: width, cons: 30.64) , y: calHeight(hei: height, cons: 96.25) ))
        rectanglePath.addCurve(to: CGPoint(x: 0, y: calHeight(hei: height, cons: 52.5)), controlPoint1: CGPoint(x: calWidth(wid: width, cons: 12.24), y: calHeight(hei: height, cons: 89.56)), controlPoint2: CGPoint(x: -0, y: calHeight(hei: height, cons: 72.07)))
        rectanglePath.addCurve(to: CGPoint(x: 0, y: calHeight(hei: height, cons: 50)), controlPoint1: CGPoint(x: 0, y: calHeight(hei: height, cons: 50)), controlPoint2: CGPoint(x: 0, y: calHeight(hei: height, cons: 50)))
        rectanglePath.addLine(to: CGPoint(x: 0, y: calHeight(hei: height, cons: 50)))
        rectanglePath.addLine(to: CGPoint(x: 0, y: calHeight(hei: height, cons: 50)))
        rectanglePath.addLine(to: CGPoint(x: 0, y: calHeight(hei: height, cons: 47.5)))
        rectanglePath.addCurve(to: CGPoint(x: calWidth(wid: width, cons: 30.64), y: calHeight(hei: height, cons: 3.75)), controlPoint1: CGPoint(x: 0, y: calHeight(hei: height, cons: 27.93)), controlPoint2: CGPoint(x: calWidth(wid: width, cons: 12.24), y: calHeight(hei: height, cons: 10.44)))
        rectanglePath.addCurve(to: CGPoint(x: calWidth(wid: width, cons: 75.5), y: -0), controlPoint1: CGPoint(x: calWidth(wid: width, cons: 42.48), y: -0), controlPoint2: CGPoint(x: calWidth(wid: width, cons: 53.49), y: -0))
        rectanglePath.addLine(to: CGPoint(x: calWidth(wid: width, cons: 76.43), y: -0))
        rectanglePath.addLine(to: CGPoint(x: calWidth(wid: width, cons: 65.61), y: -0))
        rectanglePath.close()
        
        let shape = CAShapeLayer()
        shape.fillColor = choose ? (UIColor(named: "Green")?.cgColor ?? UIColor.green.cgColor) : UIColor.white.cgColor
        shape.path = rectanglePath.cgPath
        shape.shadowColor = UIColor.lightGray.cgColor;
        shape.shadowOffset = CGSize(width: 0, height: 1.0);
        shape.shadowOpacity = 0.5;
        shape.shadowRadius = 0.0;
        balloon.layer.addSublayer(shape)
        
        let textLayer = CATextLayer()
        textLayer.string = text
        textLayer.foregroundColor = choose ? UIColor.white.cgColor : (UIColor(named: "Green")?.cgColor ?? UIColor.green.cgColor)
        textLayer.font = UIFont(name: "Roboto-Bold", size: fontSize)
        textLayer.fontSize = fontSize
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.frame = CGRect(x: 0.0, y: height/2 - 10, width: self.frame.size.width, height: height)
        textLayer.contentsScale = UIScreen.main.scale
        balloon.layer.addSublayer(textLayer)
        
        return balloon
    }
    
    func calWidth(wid : CGFloat,cons : CGFloat) -> CGFloat {
        return wid * cons / 200
    }
    func calHeight(hei : CGFloat,cons : CGFloat) -> CGFloat {
        return hei * cons / 120
    }
}
extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180.0
    }
}
