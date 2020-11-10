//
//  LoadingView.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import UIKit


class LoadingView : UIView {
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.color = .lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let loadingLabel = UILabel()
    
    private var retryHandler: (() -> Void)?
    
    init(_ view: UIView, backgroundColor: UIColor, text: String? = nil, retryHandler: (() -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.retryHandler = retryHandler
        view.addSubview(self)
        anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0, width: 0, height: 0)
        
        loadingLabel.numberOfLines = 0
        loadingLabel.textAlignment = .center
        loadingLabel.text = text ?? "Loading"
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(loadingLabel)
        addSubview(indicator)
        
        
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        
        loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 16).isActive = true
        
        addSubview(retryButton)
        retryButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        retryButton.centerYAnchor.constraint(equalTo: loadingLabel.centerYAnchor, constant: 0).isActive = true
        retryButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        retryButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(errorLabel)
        errorLabel.anchor(top: nil, leading: leadingAnchor, bottom: retryButton.topAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 32, paddingBottom: 32, paddingTrailing: 32, width: 0, height: 0)
        
        errorLabel.isHidden = true
        retryButton.isHidden = true
        isHidden = true
    }
    
    var loading: Bool = false {
        didSet {
            loading ? indicator.startAnimating() : indicator.stopAnimating()
            loadingLabel.isHidden = !loading
            isHidden = !loading
            
            if loading {
                retryButton.isHidden = true
                errorLabel.isHidden = true
            }
        }
    }
    
    func showError(_ message: String?) {
        retryButton.isHidden = false
        errorLabel.isHidden = false
        
        indicator.stopAnimating()
        loadingLabel.isHidden = true
        
        isHidden = false
        
        errorLabel.text = message == nil ? "Loading error" : message
    }
    
    @objc func retryTapped() {
        loading = true
        retryHandler?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
