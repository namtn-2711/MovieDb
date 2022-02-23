//
//  TableViewDataCell.swift
//  MovieDb
//
//  Created by Tuan on 23/02/2022.
//

import UIKit

class TableViewDataCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var poster: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

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
}
