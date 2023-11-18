//  Task.swift


import Foundation
import UIKit
import CoreLocation

class Task {
    let title: String
    let description: String
    private(set) var image: UIImage?
    var imageLocation: CLLocation?
    
    var isCompleted: Bool {
        return image != nil
    }
    
    init(title: String, description: String, image: UIImage? = nil) {
        self.title = title
        self.description = description
        self.image = image
    }
    
    func setImage(_ image: UIImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}

// Provides hardcoded tasks for the scavenger hunt.
struct TaskDataProvider {
    static let HARDCODED_TASKS: [Task] = [
        Task(title: "Take a picture of a bird", description: "What birds are there at this park?"),
        Task(title: "Take a picture of a plant", description: "What plants are there at this park?"),
        Task(title: "Take a picture of an insect", description: "What insects are there at this park?"),
    ]
}
