//
//  DetailViewController.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/8/22.
//

import UIKit

class DetailViewController: UIViewController, ViewControllerProtocol {

    let testData = [1,2,3,4,5,6,7]
    var data = [UIColor.white, UIColor.white, UIColor.white, UIColor.white, UIColor.white, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
    var detailTitle = ""
    var detailOverview = ""
    var detailImageData: Data? = Data()
    var row = 0
    lazy var movieID = 0
    
    
    
    var viewModel: ViewModelProtocol?
   
    
    // MARK: UIButton
    private lazy var myEditButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: action2)
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        let largeBoldDoc = UIImage(systemName: "square.and.pencil", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .orange
        return button
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Menlo", size: 16)
//        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let productionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont(name: "Menlo", size: 16)
//        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect, primaryAction: action1)
        button.setTitle("Details", for: UIControl.State.normal)
        button.backgroundColor = UIColor.customColorBlue  //UIColor.black.withAlphaComponent(1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.orange, for: .selected)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.tintColor = .white  //customlightGray
        
        return button
    }()
    
    private let movieImageView: UIImageView = {
        let movieImageview = UIImageView()
        movieImageview.translatesAutoresizingMaskIntoConstraints = false
        movieImageview.backgroundColor = .lightGray
        movieImageview.image?.withTintColor(UIColor.red)
        return movieImageview
    }()
    
    private let backGroundImageView: UIImageView = {
        let backGroundImageView = UIImageView()
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backGroundImageView.backgroundColor = .black
        return backGroundImageView
    }()

    private let textfield: UILabel = {
        let textfield = UILabel()
        textfield.textAlignment = .justified
        textfield.textColor = .black
        textfield.backgroundColor = .clear
        textfield.translatesAutoresizingMaskIntoConstraints = false
        //textfield.isEditable = false
        //textfield.isSelectable = false
        textfield.numberOfLines = 0
        textfield.font = UIFont(name: "Menlo", size: 13)
        textfield.sizeToFit()
        return textfield
    }()
   
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        let screenSize = UIScreen.main.bounds.size
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)

        return collectionView
    }()
    
    lazy var action2 = UIAction { [weak self] _ in
        print("This is the button tapped...")
        
        let destinationVC = DetailViewController()
//        self?.navigationController?.popToViewController(self!, animated: true)
     //   self?.navigationController!.popToRootViewController(animated: true)
//        self.navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)

        for controller in (self?.navigationController!.viewControllers)! as Array {
            if controller.isKind(of: SecondViewController.self) {
                self?.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
        //        navigationController.pop
//
////        self!.showDetailView()
//
//        let destination = EditUserViewController()
//        //        destination.imgData =  viewModel?.getImageData(by: row)
//        //        destination.storyTitle = viewModel?.getTitle(by: row)
//
//        //        self!.present(destination, animated: true, completion: nil)
//        self!.present(destination, animated: true, completion: {
//            print("It is done.")
//        })
//
        
        
    }
    
    private func getImage(imageString: String) {
        let serialQueue = DispatchQueue(label: "queue-get image")
        serialQueue.async { [weak self] in
            let urlS = "https://image.tmdb.org/t/p/w500/" + imageString
            guard let url = URL(string: urlS)
            else { return }
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self?.movieImageView.image = UIImage(data: data)
                }
                
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

   //    print("number of rows in table: \(viewModel?.totalRowsMovies)")
        ViewControllerConfigurator.assemblingMVVM(view: self)
        
//        self.viewModel?.getMovieCompany
        
        print("the description: \(detailOverview)")
        print("the title: \(detailTitle)")
        print("the row: \(row)")
        print("the image data: \(detailImageData)")
        print("movie id: \(movieID)")
        
        title = detailTitle
        titleLabel.text = "Sample Blockbuster"
        textfield.text = detailOverview
        
  //      let photoData = viewModel?.getImageData(by: row)
  //      print("photoData: \(photoData)")
        if let imageDataSafe = detailImageData {
            movieImageView.image = UIImage(data: imageDataSafe)
        }
        
        
        //"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."
        productionLabel.text = "Production Companies:"
        
        setUpUI()
        view.backgroundColor = .white//.customDarkBlue2
        // Do any additional setup after loading the view.
     //   let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTapped))

        if self.navigationController!.viewControllers.count >= 4 {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(dismissVC))
        }
     
       print("# of VCs:  \(navigationController!.viewControllers)")
        
//       Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { timer in
//           print("firing...")
//            self.viewModel?.getMovieCompany(companyID: "\(self.movieID)")
//        }
//
//        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            print("Timer fired!")
//        }
        
        
    }
    
    @objc private func dismissVC() {
        
        for controller in (self.navigationController!.viewControllers) as Array {
            
            if controller.isKind(of: SecondViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    lazy var action1 = UIAction { [weak self] _ in
        print("This is the button tapped...")
        
//        self!.showDetailView()
        
//        let destination = EditUserViewController()
//        //        destination.imgData =  viewModel?.getImageData(by: row)
//        //        destination.storyTitle = viewModel?.getTitle(by: row)
//
//        //        self!.present(destination, animated: true, completion: nil)
//        self!.present(destination, animated: true, completion: {
//            print("It is done.")
//        })
        
        
        
    }
    
    private func setUpUI() {

        let image = UIImage(named: "orange-gradient-wallpaper-1448-1581-hd-wallpapers-1024x640")?.image(alpha: 1.0)
        backGroundImageView.image = image
//        backGroundImageView.contentMode = .scaleAspectFill
//        view.backgroundColor = .white
//        contentView.backgroundColor = .black

//        contentView.addSubview(backGroundImageView)
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
  //      view.addSubview(button)
        view.addSubview(textfield)
        view.addSubview(productionLabel)
        view.addSubview(collectionView)
//        view.addSubview(myEditButton)
//        collectionView.addSubview(<#T##view: UIView##UIView#>)
//        contentView.backgroundColor = .systemPink

        // create constraints
        let safeArea = view.safeAreaLayoutGuide

//        button.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 7.0).isActive = true
//        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 25.0).isActive = true

      //  titleLabel.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
      //  titleLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 0.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        productionLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 30.0).isActive = true
        productionLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0.0).isActive = true
     //   productionLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

//        myEditButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80.0).isActive = true
//        myEditButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        myEditButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
//        myEditButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
//        backGroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
//        backGroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        backGroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        backGroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

       // textfield.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        textfield.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10.0).isActive = true
        textfield.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10.0).isActive = true
      //  textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7.0).isActive = true
        textfield.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -10.0).isActive = true
   //     textfield.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
      //  textfield.bottomAnchor.constraint(equalTo: productionLabel.topAnchor, constant: -20).isActive = true
        textfield.heightAnchor.constraint(lessThanOrEqualToConstant: 250.0).isActive = true

        collectionView.topAnchor.constraint(equalTo: productionLabel.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 220.0).isActive = true
        

        movieImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10.0).isActive = true
        movieImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 160.0).isActive = true

//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 3, height: 3)
//
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowRadius = 1.0
//        button.layer.masksToBounds = false

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    
     //   viewModel?.getMovieCompany(companyID: "634649")
        
    }
    

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
        
        return viewModel?.totalRowsCompany ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        viewModel?.getMovies()
        viewModel?.getMovieCompany(companyID: "\(movieID)")
       
        //        UICollectionViewCell {
      //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        let row = indexPath.row
         
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
                // we failed to get a PersonCell – bail out!
                return UICollectionViewCell()
              //  fatalError("Unable to dequeue MovieCell.")
            }
       // cell.titleLabel.text = String(testData[row])
        cell.backgroundColor = data[row]
//        cell.titleLabel.text = "Test cell..."
        print("cell \(row) was ceated.")
       
        
        
        if let title = viewModel?.getTitle(by: row) , let photoData = viewModel?.getImageData(by: row) {
        //    print("Title..: \(title), photoData...: \(photoData)")
            
            cell.configureCell(title: title, imageData: photoData)
        }
        
       
     
        
        
        
        return cell
        
        //        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        print("Item \(row) was pressed")
        
        let destinationVC = DetailViewController()
//        present(destinationVC, animated: true, completion: nil)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
