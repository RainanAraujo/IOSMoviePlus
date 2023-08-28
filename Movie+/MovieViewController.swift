//
//  MovieViewController.swift
//  Movie+
//
//  Created by Rainan Araújo on 24/08/23.
//

import UIKit

class MovieViewController: UIViewController {
    var movie: Movie!
    
    private let coverView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.backgroundColor = .systemGray3
        iView.layer.masksToBounds = true
        iView.contentMode = .scaleAspectFill
        return iView
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        let attrString = NSMutableAttributedString(string: "description")
        attrString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.sizeToFit()
        
        return label
    }()

    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let boldAttribute: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 14),
        .foregroundColor: UIColor.black
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        let rateAttributedString = NSMutableAttributedString(string: "Vote average: ",
                                                             attributes: boldAttribute)
        rateAttributedString.append(NSAttributedString(string: String(format: "%.2f", movie.voteAverage),
                                                       attributes: nil))
        
        rateLabel.attributedText = rateAttributedString
        
        let dateAttributedString = NSMutableAttributedString(string: "Date: ",
                                                             attributes: boldAttribute)
        dateAttributedString.append(NSAttributedString(string: movie.releaseDate,
                                                       attributes: nil))
        dateLabel.attributedText = dateAttributedString
        
        let languageAttributedString = NSMutableAttributedString(string: "Original Language: ",
                                                                 attributes: boldAttribute)
        languageAttributedString.append(NSAttributedString(string: movie.originalLanguage,
                                                           attributes: nil))
        languageLabel.attributedText = languageAttributedString
        
        coverView.download(from: movie.posterPath)
        view.addSubview(coverView)
        view.addSubview(infoStack)
        infoStack.addArrangedSubview(titleLabel)
        infoStack.addArrangedSubview(descriptionLabel)
        infoStack.addArrangedSubview(rateLabel)
        infoStack.addArrangedSubview(dateLabel)
        infoStack.addArrangedSubview(languageLabel)
        infoStack.addArrangedSubview(UIView())
        
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: view.topAnchor),
            coverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: coverView.bottomAnchor, constant:  18),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  12),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        
    }
}
