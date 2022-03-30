//
//  ViewController.swift
//  SalesByMatch_EFaggett
//
//  Created by Ethan Faggett on 3/21/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var submitButton: UIButton!
    @IBAction private func submitButtonPressed(_ sender: UIButton) {
    
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        
        if (inputTextField.text != nil) {
            vc.dataText = inputTextField.text!
        } else {
            vc.dataText = " "
        }
       
        if (inputTextField.text == "") {
            
            let message = "An Int array value is required inorder to proceed. i.e. [8,9,0]"
            let messageTitle = "Please enter an Int array for the value."
            let alert = UIAlertController(title: messageTitle, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Okay", style: .default, handler: { [self]_ in
                //Do nothing but clear the alert
            })
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBOutlet private weak var inputTextField: UITextField!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleHollowButtonFaded(submitButton)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inputTextField.text = nil
    }


}

