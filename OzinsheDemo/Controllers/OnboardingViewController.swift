//
//  OnboardingViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 16.11.2023.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var arraySlides = [["firstSlide", "ÖZINŞE-ге қош келдің!","Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"],["secondSlide","ÖZINŞE-ге қош келдің!","Кез келген құрылғыдан қара\nСүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"],["thirdSlide","ÖZINŞE-ге қош келдің!","Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated:animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = " "
    }
    
    @objc func nextButtonTouched(){
        let signInViewController = storyboard?.instantiateViewController(identifier: "SignInViewController")
        navigationController?.show(signInViewController!, sender: self)
    }
    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.viewWithTag(1000) as! UIImageView
        imageView.image = UIImage(named: arraySlides[indexPath.row][0])
        
        let titleLabel = cell.viewWithTag(1001) as! UILabel
        titleLabel.text = arraySlides[indexPath.row][1]
        
        let descriptionLabel = cell.viewWithTag(1002) as! UILabel
        descriptionLabel.text = arraySlides[indexPath.row][2]
        
        let button = cell.viewWithTag(1003) as! UIButton
        button.layer.cornerRadius = 8
        if indexPath.row == 2 {
            button.isHidden = true
        }
        button.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        let nextButton = cell.viewWithTag(1004) as! UIButton
        nextButton.layer.cornerRadius = 12
        if indexPath.row != 2 {
            nextButton.isHidden = true
        }
        button.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
    }
}
