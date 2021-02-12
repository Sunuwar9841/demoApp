//
//  MoviesViewController.swift
//  flixster
//
//  Created by alisha.sunuwar on 2/6/21.
//

import UIKit
import AlamofireImage

// step 1 add UITableViewDataSource, UITableViewDelegat
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String : Any]]()

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        // number on table bar - step 3
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
        print("Hello")
        //API call
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, reszponse, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
            // dataDIc holds the data
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            //print(dataDictionary)
            
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.tableView.reloadData() // it will add the movie title to tableView
            print(dataDictionary)
           
           }
        }
        task.resume()
    }
    // function moved and fill the body to make row in table - step 2
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell() // cell creation
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell// deq create recycle cell to save memory
        
        let movie = movies[indexPath.row] // array taking each row and stored
        let title = movie["title"]  as! String //go bACK TO API, its a stirng and I want the title to be string as! String
        let synopsis = movie["overview"] as! String
        //cell.textLabel!.text = title //  \(indexPath.row) changed   50 times
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:baseUrl + posterPath)      //URL validat correct form not in string
        
        cell.posterImgView.af_setImage(withURL: posterUrl!)
        return cell
        
        
        
    }
    
    
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

        

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        
    
    
    

    /*;
    // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a ittle preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


