//
//  WelcomeView.swift
//  Nearby
//
//  Created by Marcos Roberto Lemos Veloso on 11/12/24.
//

import Foundation
import UIKit

class WelcomeView: UIView {
    var didTapButton: (() -> Void?)?
    
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Boas vindas ao Nearby!"
        label.font = Typography.titleXL
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let description = UILabel()
        description.text = "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        description.font = Typography.textMD
        description.textColor = Colors.gray500
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private let tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "Veja como funciona:"
        label.font = Typography.textMD
        label.textColor = Colors.gray500
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 24
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Começar", for: .normal)
        button.titleLabel?.font = Typography.action
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor(red: 23/255, green: 84/255, blue: 46/255, alpha: 1).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 15)
        button.layer.shadowRadius = 10 // Blur
        button.layer.shadowOpacity = 0.25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupTips()
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(tipsLabel)
        addSubview(tipsStackView)
        addSubview(startButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            tipsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            tipsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            
            tipsStackView.topAnchor.constraint(equalTo: tipsLabel.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -48),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            startButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    @objc private func didTap() {
        didTapButton?()
    }
    
    private func setupTips() {
        guard let icon1 = UIImage(named: "mapIcon") else {return}
        let tip1 = TipsView(icon: icon1,
                            title: "Encontre estabelecimentos",
                            description: "Veja locais perto de você que são parceiros Nearby")
        
        let tip2 = TipsView(icon: UIImage(named: "qrcode") ?? UIImage(),
                           title: "Ative o cupom com QR Code",
                           description: "Escaneie o código no estabelecimento para usar o benefício")

        // not recommended
        let tip3 = TipsView(icon: UIImage(named: "ticket")!,
                           title: "Garanta vantagens perto de você",
                           description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento")
        
        tipsStackView.addArrangedSubview(tip1)
        tipsStackView.addArrangedSubview(tip2)
        tipsStackView.addArrangedSubview(tip3)
    }
}
