//
//  ViewController.swift
//  ImageDisplayApp
//
//  Created by Ethan Faggett on 3/29/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Elements
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Get Image", for: UIControl.State.normal)
        button.backgroundColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let apiImageView: UIImageView = {
        let profileImageview = UIImageView()
        profileImageview.translatesAutoresizingMaskIntoConstraints = false
        profileImageview.backgroundColor = .clear
        profileImageview.image?.withTintColor(UIColor.red)
        return profileImageview
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .black
        return backGroundImageView
    }()
    
    private lazy var action1 = UIAction { [weak self] _ in
//        self?.getImage()
        print("This is the button tapped...")
        
        let serialQueue = DispatchQueue(label: "queue-get image")
        serialQueue.async { [weak self] in
//            let urlS = "https://i.picsum.photos"
            let urlS = "https://picsum.photos"
//            DispatchQueue.main.async {
            let height = Int(self!.apiImageView.frame.height)
            let width = Int(self!.apiImageView.frame.width)
            print("H: \(height), W: \(width)")
//            }
            
            let theURL = "https://picsum.photos/{width}/{height}"
            
            let urlFinal = urlS +     "/" + "\(width)" + "/" + "\(height)"
            print("urlFinal: \(urlFinal)")
            guard let url = URL(string: urlFinal)
            else { return }
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async { [self] in
                    self?.apiImageView.image = UIImage(data: data)
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 1.0
        button.layer.masksToBounds = false
        
        setUpUI()
        
        
        
    }

    private func setUpUI() {
       
        let image = UIImage(named: "Green-Bubbles-Awesome-Background")?.image(alpha: 0.25)
        backGroundImageView.image = image
        backGroundImageView.contentMode = .scaleAspectFill
        
        view.backgroundColor = .black
        
        view.addSubview(backGroundImageView)
        view.addSubview(button)
        view.addSubview(apiImageView)
        
        // create constraints
        let safeArea = view.safeAreaLayoutGuide
        
        button.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -7.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backGroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backGroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        apiImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        apiImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        apiImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        apiImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
    }
    
    @objc private func getImage() {
        let serialQueue = DispatchQueue(label: "queue-get image")
        serialQueue.async { [weak self] in
            let urlS = "https://i.picsum.photos/id/53/100/100"
            guard let url = URL(string: urlS)
            else { return }
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self?.apiImageView.image = UIImage(data: data)
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }

}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
