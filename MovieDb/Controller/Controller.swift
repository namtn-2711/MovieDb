//
//  Controller.swift
//  MovieDb
//
//  Created by Tuan on 22/02/2022.
//

import UIKit

class Controller: UIViewController {
    
    var movieData : [Result] = []
    
    let tableviewData : UITableView = {
        let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewDataCell", bundle: .main)
        tableviewData.register(nib, forCellReuseIdentifier: "cellData")
        tableviewData.dataSource = self
        tableviewData.delegate = self
        view.addSubview(tableviewData)
        fetchData()
        
    }
    
    func fetchData() {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=14360ac6b892f41c0cadc709209d3fbe&page=1"
        let url = URL(string: urlString)!

        let task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            do{
             let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                DispatchQueue.global().async {
                    self.movieData = result.results
                }
                DispatchQueue.main.async {
                    self.tableviewData.reloadData()
                }
            }catch{
                print(error)
            }
        
       }
            task.resume()
    }

}



extension Controller:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! TableViewDataCell
        let data = movieData[indexPath.row]
        cell.title.text = data.title
        cell.subtitle.text = "Popular: \(data.popularity)"
        cell.rating.text = String(data.voteAverage)
        cell.fetchImage(data: data.posterPath)
        return cell
    }
    
    
}
