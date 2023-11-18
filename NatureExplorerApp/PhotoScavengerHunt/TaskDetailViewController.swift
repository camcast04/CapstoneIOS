//  TaskDetailViewController.swift


import UIKit
import MapKit
import PhotosUI

class TaskDetailViewController: UIViewController, PHPickerViewControllerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskStatusImageView: UIImageView!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var attachPhotoButton: UIButton!
    
    var task: Task!
    
    private struct LayoutConstants {
        static let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        static let doneImageName = "done"
        static let notDoneImageName = "not-done"
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(PhotoAnnotationView.self, forAnnotationViewWithReuseIdentifier: PhotoAnnotationView.identifier)
        configure(with: task)
    }
    
    // MARK: - IBActions
    @IBAction func didTapAttachPhotoButton(_ sender: UIButton) {
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized {
            requestAuthorization()
        } else {
            openPhotoPicker()
        }
    }
    
    // MARK: - Configuration
    private func configure(with task: Task) {
        navigationItem.title = task.title
        taskTitleLabel.text = task.title
        taskDescriptionLabel.text = task.description
        updateTaskStatusImage()
        attachPhotoButton.isHidden = task.isCompleted
        if let location = task.imageLocation {
            addMapAnnotation(location)
        }
    }
    
    private func updateTaskStatusImage() {
        let imageName = task.isCompleted ? LayoutConstants.doneImageName : LayoutConstants.notDoneImageName
        taskStatusImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        taskStatusImageView.tintColor = task.isCompleted ? .systemGreen : .systemRed
    }
    
    // MARK: - Image Uploading and Map Annotation
    private func uploadImage(_ image: UIImage, location: CLLocation) {
        self.task.setImage(image, with: location)
        DispatchQueue.main.async {
            self.configure(with: self.task)
        }
    }

    private func addMapAnnotation(_ location: CLLocation) {
        let coordinate = location.coordinate
        let region = MKCoordinateRegion(center: coordinate, span: LayoutConstants.coordinateSpan)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - Photo Picker
    private func requestAuthorization() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                self?.openPhotoPicker()
            }
        }
    }
    
    private func openPhotoPicker() {
        DispatchQueue.main.async {
            var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            config.filter = .images
            config.selectionLimit = 1
            let controller = PHPickerViewController(configuration: config)
            controller.delegate = self
            self.present(controller, animated: true)
        }
    }
    
    // MARK: - PHPickerViewControllerDelegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let imageResult = results.first,
              imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        imageResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
            guard let self = self, let image = object as? UIImage else { return }
            // Replace with actual coordinates or location fetching logic
            let currentLocation = CLLocation(latitude: 25.286615, longitude: -80.898651)
            DispatchQueue.main.async {
                self.uploadImage(image, location: currentLocation)
            }
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PhotoAnnotationView.identifier, for: annotation) as? PhotoAnnotationView else { return nil }
        annotationView.configure(with: task)
        return annotationView
    }
}

// Define ParkArea
struct ParkArea {
    let name: String
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance

    static let everglades = ParkArea(
        name: "Everglades National Park",
        coordinate: CLLocationCoordinate2D(latitude: 25.286615, longitude: -80.898651),
        radius: 30000
    )

    static let bigCypress = ParkArea(
        name: "Big Cypress",
        coordinate: CLLocationCoordinate2D(latitude: 25.857596, longitude: -81.032984),
        radius: 20000
    )
}
