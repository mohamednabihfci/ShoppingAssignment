//
//  HomeTableViewCell.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeTableViewCell: UITableViewCell {
    //MARK: Variable
    static let Identifier = "HomeTableViewCell"
    let viewModel = HomeCellViewModel()
    let disposeBag = DisposeBag()
    //MARK: IBOutlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpAppearance()
        setupRxBindings()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
       
    }
    func setUpAppearance() {
        self.addToCartBtn.cardViewAppearance(cornerRadius: 4.0)
    }
    func setupRxBindings() {
        
        viewModel.car.subscribe(onNext: { [weak self] (car) in
            
            guard let self = self else  {
                return
            }
            self.viewModel.name.accept(car?.name ?? "")
        }) .disposed(by: disposeBag)
        
        viewModel.name.bind(to: lblName.rx.text).disposed(by: disposeBag)
        
        addToCartBtn.rx.tap
            .bind { [weak self] in
                self?.viewModel.addToCart()
            }
            .disposed(by: disposeBag)
        
        viewModel.loadingState
            .observe(on: MainScheduler())
            .subscribe(onNext: {[weak self] (state) in
                guard let self = self else {
                    return
                }
                switch state {
                    case .ideal:
                        break
                    case .loading:
                        self.showLoading(loading: true)
                    case .loaded:
                        self.showLoading(loading: false)
                }
            }).disposed(by: disposeBag)
    }
    func showLoading(loading: Bool) {
        loading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        self.addToCartBtn.setTitle(loading ? "" : "Add to cart", for: .normal)
    }
    
}
