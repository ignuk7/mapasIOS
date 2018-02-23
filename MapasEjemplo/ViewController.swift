//
//  ViewController.swift
//  MapasEjemplo
//
//  Created by CETYS on 17/01/18.
//  Copyright © 2018 CETYS. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet var miMapa: MKMapView!
    
    //para poner el mapa en satelite o standard
    @IBAction func cambiaTipoMapa(_ sender: UIBarButtonItem) {
        if(miMapa.mapType == MKMapType.standard){
            miMapa.mapType = MKMapType.satellite
            sender.title = "Normal"
        }else{
            miMapa.mapType = MKMapType.standard
            sender.title = "Satelite"
        }
    }
    
    //para poner una localizxacion en el mapa
    @IBAction func universidad(_ sender: UIBarButtonItem) {
        let coordenadasUFV = CLLocationCoordinate2D(latitude: 40.44075, longitude: -3.834)
        let miZoom: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let regionUFV = MKCoordinateRegion(center: coordenadasUFV, span: miZoom)
        
        miMapa.setRegion(regionUFV, animated: true)
    }
    //poner informacion  en la localizacon
    override func viewDidLoad() {
        super.viewDidLoad()
        miMapa.delegate = self
        
        let coordenadasUFV = CLLocationCoordinate2D(latitude: 40.44075, longitude: -3.834)
        let miAnotacion = MKPointAnnotation()
        miAnotacion.coordinate = coordenadasUFV
        miAnotacion.title = "Universidad Francisco de Vitoria"
        miAnotacion.subtitle = "UFV"
        
        miMapa.addAnnotation(miAnotacion)
        
        
        let coordenadasCETYS = CLLocationCoordinate2D(latitude: 40.441024, longitude: -3.834954)
        let miAnotacion2 = MKPointAnnotation()
        miAnotacion2.coordinate = coordenadasCETYS
        miAnotacion2.title = "CETYS"
        miAnotacion2.subtitle = "BUUUS"
        
        miMapa.addAnnotation(miAnotacion2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //poner chincheta e imagen en el mapa
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = .orange
            //imagen que aparece a la izquierda
            var imagen : UIImage
            if (annotation.title! == "CETYS"){
                imagen = UIImage(named: "cetys.png")!
            }else{
                imagen = UIImage(named: "ufv.png")!
            }
            
            
            let logo = UIImageView(image:imagen)
            pinView!.image = logo.image
            pinView!.leftCalloutAccessoryView = logo
            
        }else{
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}

