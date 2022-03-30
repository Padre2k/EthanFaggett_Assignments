//
//  DetailedViewController.swift
//  SalesByMatch_EFaggett
//
//  Created by Ethan Faggett on 3/21/22.
//

import UIKit

class DetailedViewController: UIViewController {

    //  MARK: - Properties
    @IBOutlet private weak var textFieldDisplay: UITextView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet weak var mainTextLabel: UILabel!
    var dataText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detailed View"
        
        let trimmedData = dataText.trimmingAllSpaces()
        
        let array = trimmedData.components(separatedBy: ",")
        
        print("DataTesxt: \(trimmedData)")
        print("Array1: \(array)")
        
        let array2 = trimmedData.components(separatedBy: ",")
       
        mainTextLabel.text = "\(array2)"
        
        let myInts = array2.map { (array2) -> Int in
            return Int(array2) ?? 1
        }
        
        let payload = sockMerchant(n: myInts)
        print("Total pairs of matching socks: \(payload.0) \n\(payload.1)")
        
        
        DispatchQueue.main.async { [self] in
            textFieldDisplay.text = "Total pairs of matching socks: \(payload.0) \n\nDetails:\n \(payload.1)"
                    }
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    // MARK: - function(s)
    func sockMerchant(n: [Int])-> (Int, String) {

        var matchSock = 0
        var counts: [Int: Int] = [:]
        var details = ""

        for item in n {
            counts[item] = (counts[item] ?? 0) + 1
        }

        print(counts, "\n")

        for (key, value) in counts {
            
            if value % 2 == 1 {
                if (value > 1) {
                    print("(\(key)) has \((value-1)/2) pair(s).")
                    details += "(\(key)) has \((value-1)/2) pair(s). \n"
                    }
                matchSock += (value-1)/2
            }
            if value % 2 == 0 {
                if (value > 1) {
                    print("(\(key)) has \(value/2) pair(s).")
                    details += "(\(key)) has \(value/2) pair(s). \n"
                    }
                matchSock += value/2
            }
            
        }


        return (matchSock, details)
    }
    
}

// MARK: - Extensions
extension String {
    func trimmingAllSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return components(separatedBy: characterSet).joined()
    }
}
