//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import Toucan

class PhotoMapViewController: UIViewController, LocationsViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MKMapViewDelegate {

  @IBOutlet weak var myMapView: MKMapView!
  @IBOutlet weak var cameraButton: UIButton!
  var previewImage: UIImage!
  var fullImage: UIImage!
  var selectedAnnotation: PhotoAnnotation?

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setInitialMapLocation()
    configureCameraButton()
    myMapView.delegate = self
    
  }
  @IBAction func onTouchCameraButton(_ sender: Any) {
    instantiateUIImagePickerController()
  }
  
  func instantiateUIImagePickerController() {
    let vc = UIImagePickerController()
    vc.delegate = self
    vc.allowsEditing = true
    //vc.sourceType = UIImagePickerControllerSourceType.camera
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      print("Camera is available 📸")
      vc.sourceType = .camera
    } else {
      print("Camera 🚫 available so we will use photo library instead")
      vc.sourceType = .photoLibrary
    }
    
    self.present(vc, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String : Any]) {
    // Get the image captured by the UIImagePickerController
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    
    let resizedImage = Toucan.Resize.resizeImage(editedImage, size: CGSize(width: 45, height: 45))
    
    // Do something with the images (based on your use case)
    fullImage = originalImage
    previewImage = resizedImage
    // Dismiss UIImagePickerController to go back to your original view controller, a
    dismiss(animated: false) {
      // Launch the LocationsViewController
      self.performSegue(withIdentifier: "tagSegue", sender: nil)
    }
  }
  
  func setInitialMapLocation() {
    //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
    let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                          MKCoordinateSpanMake(0.1, 0.1))
    myMapView.setRegion(sfRegion, animated: false)
  }
  
  func configureCameraButton() {
    cameraButton.layer.cornerRadius = cameraButton.frame.height/2
    cameraButton.layer.borderWidth = 2
    cameraButton.layer.borderColor = UIColor.white.cgColor
  }
  // Pass the selected object to the new view controller.
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    if segue.identifier == "tagSegue" {
      // Pass the selected object to the new view controller.
      let destinationViewController = segue.destination as! LocationsViewController
      destinationViewController.delegate = self
    } else if segue.identifier == "fullImageSegue" {
      let destinationViewController = segue.destination as! FullImageViewController
      destinationViewController.bigImage = selectedAnnotation?.photo
    }
  }
  
  // Conform to the LocationsViewControllerDelegate protocol
  func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
    
    let locationCoordinate = CLLocationCoordinate2D(latitude: latitude as! Double, longitude: longitude as! Double)
    let annotation = PhotoAnnotation()
    annotation.coordinate = locationCoordinate
    annotation.photo = fullImage
    myMapView.addAnnotation(annotation)
    
    self.navigationController? .popToViewController(self, animated: true)
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let reuseID = "myAnnotationView"
    
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
    
    if (annotationView == nil) {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
      annotationView!.canShowCallout = true
      annotationView!.leftCalloutAccessoryView = UIImageView(frame: CGRect(x:0, y:0, width: 50, height:50))
      annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
    }
    let imageView = annotationView?.leftCalloutAccessoryView as! UIImageView
    imageView.image = previewImage
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    self.selectedAnnotation = view.annotation as? PhotoAnnotation
    self.performSegue(withIdentifier: "fullImageSegue", sender: nil)
  }

}

class PhotoAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
  var photo: UIImage!
  
  var title: String? {
    return "\(coordinate.latitude)"
  }
}
