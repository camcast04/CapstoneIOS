// ViewController.swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        if username == "cami" && password == "1234" {
            // Navigate to the next view
            performSegue(withIdentifier: "ShowParkOptionsSegue", sender: nil)
        } else {
            // Handle incorrect credentials
            print("Login Failed")
        }
    }
}
