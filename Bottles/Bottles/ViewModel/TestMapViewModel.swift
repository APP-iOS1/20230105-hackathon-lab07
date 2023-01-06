//
//  TestMapViewModel.swift
//  Bottles
//
//  Created by BOMBSGIE on 2023/01/06.
//

import Foundation
import MapKit

class TestMapViewModel: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    @Published var mapView: MKMapView = .init()
    @Published var manager: CLLocationManager = .init()
    @Published var isChanging: Bool = false
    
    override init() {
        super.init()
        self.configureLocationManager()
    }
    
    func configureLocationManager() {
        mapView.delegate = self
        manager.delegate = self
        
        let status = manager.authorizationStatus
        
        if status == .notDetermined {
            manager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.moveFocusOnUserLocation()
        }
    }
    
    func moveFocusOnUserLocation() {
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.follow, animated: true)
        }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
           DispatchQueue.main.async {
               self.isChanging = true
           }
       }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
           
            
            DispatchQueue.main.async {
                self.isChanging = false
            }
        }
}
