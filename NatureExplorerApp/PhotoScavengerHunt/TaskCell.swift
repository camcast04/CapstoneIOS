//  TaskCell.swift



import UIKit

class TaskCell: UITableViewCell {
    static let identifier = "TaskCell"
    
    private struct Constants {
        static let imageViewDimension: CGFloat = 32.0
        static let doneImageName = "done"
        static let notDoneImageName = "not-done"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Configure the cell with the given task.
    func configure(with task: Task) {
        textLabel?.text = task.title
        let accessoryImageView = createAccessoryImageView(for: task)
        accessoryView = accessoryImageView
    }
    
    // Create an accessory image view based on the task's completion status.
    private func createAccessoryImageView(for task: Task) -> UIImageView {
        let imageName = task.isCompleted ? Constants.doneImageName : Constants.notDoneImageName
        let imageView = UIImageView(image: UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = task.isCompleted ? .systemGreen : .systemRed
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: Constants.imageViewDimension, height: Constants.imageViewDimension)
        return imageView
    }
    
    // Prepare the cell for reuse by resetting its contents.
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        accessoryView = nil
    }
}
