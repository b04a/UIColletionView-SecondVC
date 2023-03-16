//
//  SecondView.swift
//  CollectionView+SecondVC
//
//  Created by Danil Bochkarev on 15.03.2023.
//

import UIKit
import SnapKit

class SelectedViewController: UIViewController {
    private let selectedText: String
    private let label = UILabel()
    
    init(selectedText: String) {
        self.selectedText = selectedText
        super.init(nibName: nil, bundle: nil)
        title = "Selected"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        label.text = selectedText
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

