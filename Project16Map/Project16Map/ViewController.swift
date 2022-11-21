//
//  ViewController.swift
//  Project16Map
//
//  Created by COBE on 24.08.2022..
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let mapTypes = ["hybrid": MKMapType.hybrid, "hybridFlyover": MKMapType.hybridFlyover, "mutedStandard": MKMapType.mutedStandard, "satellite": MKMapType.satellite, "satelliteFlyover": MKMapType.satelliteFlyover, "standard": MKMapType.standard]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Maps", style: .plain, target: self, action: #selector(chooseMap))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home of the 2012 Summer Olympics", wikiUrl: "https://en.wikipedia.org/wiki/London")
        
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago", wikiUrl: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light", wikiUrl: "https://en.wikipedia.org/wiki/Paris")
        
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it", wikiUrl: "https://en.wikipedia.org/wiki/Rome")
        
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George Wahington", wikiUrl: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotations([london,oslo,paris,rome,washington])
        
    }
    
    @objc func chooseMap() {
        
        let ac = UIAlertController(title: "Choose Type of maps", message: nil, preferredStyle: .actionSheet)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        for mapType in Array(mapTypes.keys).sorted(by: <) {
        ac.addAction(UIAlertAction(title: mapType, style: .default, handler: typeOfMaps))
        }
      //  ac.addAction(UIAlertAction(title: "Standard Map", style: .default, handler: typeOfMaps))
        
   
        present(ac, animated: true)
    }
    
    func typeOfMaps(action: UIAlertAction) {
        
        guard let title = action.title else { return }
        
        if let type = mapTypes[title] {
            mapView.mapType = type
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .white
        return annotationView
    }


    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Wiki", style: .default, handler: {
                                  [weak self] _ in
                                   self?.openWiki(url: capital.wikiUrl)
        } ))
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func openWiki(url: String) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
            vc.website = url
            navigationController?.pushViewController(vc, animated: true)
        }
}

}
