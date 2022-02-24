//
//  DetailViewController.swift
//  MovieDb
//
//  Created by Tuan on 23/02/2022.
//

import UIKit

class DetailView: UIViewController {
        
    let poster = UIImageView()
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let overviewLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI(){
        poster.layer.borderWidth = 0.5
        poster.layer.borderColor = UIColor.gray.cgColor
        
        titleLabel.text = "TitleLabel"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
 
        releaseDateLabel.text = "Realease Label"
        releaseDateLabel.font = UIFont.boldSystemFont(ofSize: 20)
   
        overviewLabel.numberOfLines = 0
        overviewLabel.text = ""
 
        let stackView = UIStackView(arrangedSubviews: [poster,titleLabel,releaseDateLabel,overviewLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func fetchImage(data:String){
        let url = "https://image.tmdb.org/t/p/w342/\(data)"
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)){
            (data, response, error) in
            
            do{
                let datas = try data
                DispatchQueue.main.async {
                    self.poster.image = UIImage(data: datas!)
                }
            }catch{
                print(error)
            }
        }.resume()
    }
    
    func fetchLabel(title: String, releaseDate: String, overview: String){
        DispatchQueue.main.async { [self] in
            titleLabel.text = title
            releaseDateLabel.text = releaseDate
            overviewLabel.text = overview
        }
    }
    
}
