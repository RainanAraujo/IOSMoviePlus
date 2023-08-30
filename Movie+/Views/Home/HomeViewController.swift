//
//  HomeViewController.swift
//  Movie+
//
//  Created by Rainan Araújo on 30/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    private var movies: [Movie] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28,weight: .black)
        label.textColor = .black
        label.text = "Top rated"
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = true
        table.register(MovieCell.self, forCellReuseIdentifier: MovieCell.id)
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        fetchPokeAPI()
    }
    
    private func addViewsInHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchPokeAPI() {
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a351100c0c0e4c3a58eb56a255e10145&language=pt-BR")!
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil { return }
            guard let data else { return }
            guard let moviesRes = try? decoder.decode(TMDBMovie.self, from: data) else { return }
            self.movies = moviesRes.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).resume()
    }
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id, for: indexPath) as? MovieCell else {
            fatalError("error")
        }
        let movie = movies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieView = MovieViewController()
        movieView.movie = movie
        present(movieView, animated: true, completion: nil)
    }
}
