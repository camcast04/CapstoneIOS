//  PhotoAnnotationView.swift


import UIKit
import MapKit

class PhotoAnnotationView: MKAnnotationView {
    static let identifier = "PhotoAnnotationView"

    private struct LayoutConstants {
        static let containerViewSize = CGSize(width: 75, height: 75)
        static let containerViewCornerRadius: CGFloat = 16.0
        static let imageViewCornerRadius: CGFloat = 8.0
        static let bottomCornerViewSize = CGSize(width: 24, height: 24)
        static let bottomCornerViewCornerRadius: CGFloat = 4.0
        static let bottomCornerViewRotationAngle = (39.0 * CGFloat.pi) / 180
        static let padding: CGFloat = 8.0
    }
    
    private var task: Task!
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: LayoutConstants.containerViewSize))
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.containerViewCornerRadius
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = LayoutConstants.imageViewCornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var bottomCornerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.bottomCornerViewCornerRadius
        return view
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the annotation view with the given task.
    /// - Parameter task: The task to configure the annotation view with.
    func configure(with task: Task) {
        self.task = task
        imageView.image = task.image
    }
    
    private func setupViews() {
        setupContainerView()
        setupBottomCornerView()
        setupImageView()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
    }
    
    private func setupImageView() {
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LayoutConstants.padding),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.padding),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LayoutConstants.padding),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -LayoutConstants.padding)
        ])
    }
    
    private func setupBottomCornerView() {
        containerView.addSubview(bottomCornerView)
        NSLayoutConstraint.activate([
            bottomCornerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -LayoutConstants.padding),
            bottomCornerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bottomCornerView.widthAnchor.constraint(equalToConstant: LayoutConstants.bottomCornerViewSize.width),
            bottomCornerView.heightAnchor.constraint(equalToConstant: LayoutConstants.bottomCornerViewSize.height)
        ])
        bottomCornerView.transform = CGAffineTransform(rotationAngle: LayoutConstants.bottomCornerViewRotationAngle)
    }
}
