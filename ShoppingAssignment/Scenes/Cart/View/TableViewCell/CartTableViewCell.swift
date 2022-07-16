//
//  CartTableViewCell.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/13/22.
//

import UIKit
import RxSwift
import RxCocoa

class CartTableViewCell: UITableViewCell {
    //MARK: Variable
    static let Identifier = "CartTableViewCell"
    let viewModel = CartCellViewModel()
    let disposeBag = DisposeBag()
    //MARK: IBOutlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var quntityStepperView: UIView!
    @IBOutlet weak var quntityStepperPlus: UIButton!
    @IBOutlet weak var quntityStepperMinus: UIButton!
    @IBOutlet weak var quntityStepperValue: UILabel!
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
    
}
extension CartTableViewCell {
    //MARK: Method
    func setupRxBindings() {
        quntityStepperMinus.rx.tap .bind { [weak self] in
            guard let self = self else { return }
            var qty = self.viewModel.quntity.value
            qty -= 1
            self.stepperValueChanged(qty: qty)
        }
        .disposed(by: disposeBag)
        quntityStepperPlus.rx.tap .bind { [weak self] in
            guard let self = self else { return }
            var qty = self.viewModel.quntity.value
            qty += 1
            self.stepperValueChanged(qty: qty)
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
                        self.activityIndicator.isHidden = false
                        self.activityIndicator.startAnimating()
                    case .loaded:
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
        
       
        
        viewModel.name.bind(to: lblName.rx.text).disposed(by: disposeBag)
        viewModel.quntity.map({"\($0)"}).bind(to: quntityStepperValue.rx.text).disposed(by: disposeBag)
    }
    func setUpAppearance() {
        self.quntityStepperView.cardViewAppearance(cornerRadius: 4.0)
    }
    
    func stepperValueChanged(qty: Int) {
        guard let car = self.viewModel.cartItem.keys.first else {return}
        viewModel.updateCart(car: car, qty: Double(qty))
        
    }
    
}
