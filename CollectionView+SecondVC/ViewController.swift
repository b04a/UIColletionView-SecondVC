import UIKit
import SnapKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private let cellIdentifier = "Cell"
    private let cellSpacing: CGFloat = 8
    private let numberOfCells = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        let itemSize = (view.bounds.width - cellSpacing * 6) / 5
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(cellSpacing)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(itemSize)
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .systemYellow
        
        let button = UIButton()
        button.setTitle("TEST", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        cell.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return cell
    }
    
    @objc func didTapButton(sender: UIButton) {
        guard let indexPath = collectionView.indexPath(for: sender.superview as! UICollectionViewCell) else {
            return
        }
        
        let selectedText = "Cell \(indexPath.item + 1) selected"
        
        let selectedViewController = SelectedViewController(selectedText: selectedText)
        let navController = UINavigationController(rootViewController: selectedViewController)
        navController.modalPresentationStyle = .fullScreen
        selectedViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissSelectedViewController))
        
        present(navController, animated: true, completion: nil)
    }
    
    @objc func dismissSelectedViewController() {
        dismiss(animated: true, completion: nil)
    }
}
