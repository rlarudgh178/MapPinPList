//
//  ViewController.swift
//  MapPinPLiist
//
//  Created by 김종현 on 2017. 9. 17..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        zoomToRegion()
        
//      Annotation(Pin) 꼽기
//        let anno01 = MKPointAnnotation()
//        anno01.coordinate.latitude = 35.166197
//        anno01.coordinate.longitude = 129.072594
//        anno01.title = "DIT 동의과학대학교"
//        anno01.subtitle = "나의 꿈이 자라는 곳"
//        myMapView.addAnnotation(anno01)
        
        //////////
        
        let path = Bundle.main.path(forResource: "ViewPoint", ofType: "plist")
        print("path = \(String(describing: path))")
        
        let contents = NSArray(contentsOfFile: path!)
        print("path = \(String(describing: contents))")
        
        var annotations = [MKPointAnnotation]()
        
        if let myItems = contents {
            for item in myItems {
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                let annotation = MKPointAnnotation()
                
                print("lat = \(String(describing: lat))")
                
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                
                print("myLat = \(myLat)")
                
                
                annotation.coordinate.latitude = myLat
                annotation.coordinate.longitude = myLong
                annotation.title = title as? String
                annotation.subtitle = subTitle as? String
                
                annotations.append(annotation)
                
            }
        }
        
        myMapView.addAnnotations(annotations)

    }
    
    func zoomToRegion() {
        
        //  DIT 위치정보 35.166197, 129.072594
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        myMapView.setRegion(region, animated: true)

    }

}

