//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Marissa Bush on 12/2/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func didTapScreen(_ sender: Any) {
            view.endEditing(true);
    }
    var alertController: UIAlertController!
    var alertError: String = ""
    
    @IBAction func didTapLogin(_ sender: Any) {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if username.isEmpty {
            let alertController = UIAlertController(title: "Username Required", message: "Please input username", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: {
                    self.usernameTextField.becomeFirstResponder()
                })
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true)
        }
        else if password.isEmpty{
            let alertController = UIAlertController(title: "Password Required", message: "Please input password", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: {
                    self.passwordTextField.becomeFirstResponder()
                })
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true)
        }
        else {
            PFUser.logInWithUsername(inBackground: username.trimmingCharacters(in: .whitespaces), password: password, block: { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                } else {
                    print("User logged in successfully")
                    
                    // display view controller that needs to shown after successful login
                    self.dismiss(animated: true, completion: nil)//performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            })
        }
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    @IBAction func didTapSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "signup", sender: UIButton())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // check if user is logged in.
        if PFUser.current() != nil {
            // if there is a logged in user then load the home view controller
            print("Already Logged In")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
