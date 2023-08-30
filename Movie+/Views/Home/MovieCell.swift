//
//  MovieCell.swift
//  Movie+
//
//  Created by Rainan Araújo on 11/08/23.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let id = "MovieCell"
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private let coverView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.layer.cornerRadius = 5
        iView.backgroundColor = .systemGray3
        iView.layer.masksToBounds = true
        return iView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addViewsInHierarchy()
        setupConstraints()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    public func setup(movie: Movie) {
        titleLabel.text = movie.title
        rateLabel.text = "Vote average:" + String(format: "%f", movie.voteAverage)
        dateLabel.text = "Date:"+movie.releaseDate
        coverView.download(from: movie.posterPath)
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func addViewsInHierarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(coverView)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(rateLabel)
        verticalStack.addArrangedSubview(dateLabel)
        verticalStack.addArrangedSubview(UIView())
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            coverView.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}
