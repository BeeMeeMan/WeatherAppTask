////
////  InfoContainer.swift
////  WeatherAppTask
////
////  Created by Yevhenii Korsun on 14.09.2022.
////
//
//import UIKit
//
//enum InfoContainer {
//    case temperature
//    case humidity
//    case wind
//
//    var iconName: String {
//        switch self {
//        case .temperature: return "ic_temp"
//        case .humidity: return "ic_humidity"
//        case .wind: return "ic_wind"
//        }
//    }
//}
//
//protocol InputContainerViewDelegate: AnyObject {
//    func detectInput()
//}
//
//class InputContainerView: UIView {
//    
//    // MARK: - Properties
//    
//    let textField = UITextField()
//    var type: InputContainerType
//    weak var delegate: InputContainerViewDelegate?
//    
//    // MARK: - Lifecycle
//    
//    init(type: InputContainerType) {
//        self.type = type
//        super.init(frame: .zero)
//        
//        setHeight(50)
//        
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: type.imageName)
//        imageView.tintColor = .white.withAlphaComponent(0.83)
//        addSubview(imageView)
//        imageView.center(by: .YAxis, inView: self)
//        imageView.anchor(left: leftAnchor, paddingLeft: 8)
//        imageView.setDimensions(height: 24, width: 28)
//        
//        let lineView = UIView()
//        lineView.backgroundColor = .white.withAlphaComponent(0.83)
//        lineView.setHeight(0.75)
//        addSubview(lineView)
//        lineView.anchor(bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingBottom: 4, paddingLeft: 4, paddingRight: 4)
//        
//        textField.borderStyle = .none
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.textColor = .white.withAlphaComponent(0.83)
//        textField.keyboardAppearance = .dark
//        textField.attributedPlaceholder = NSAttributedString(string: type.placeholder, attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.83)])
//        addSubview(textField)
//        textField.center(by: .YAxis, inView: self)
//        textField.anchor(left: imageView.rightAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8)
//        textField.isSecureTextEntry = type.isSecure
//        textField.addTarget(self, action: #selector(detectInput), for: .editingChanged)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Selectors
//    
//    @objc func detectInput() {
//        delegate?.detectInput()
//    }
//}
