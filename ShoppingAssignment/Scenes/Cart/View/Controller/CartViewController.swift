//
//  CartViewController.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/13/22.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //MARK: Variable
    let viewModel = CartViewModel()
    let disposeBag = DisposeBag()
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "My Cart"
        setupNibFiles()
        setupRxBindings()
        viewModel.getCart()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    //MARK: Method
    func setupNibFiles() {
        tableView.registerCellNib(cellClass: CartTableViewCell.self)
    }
    func setupRxBindings() {
        viewModel.cartItems
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: CartTableViewCell.Identifier,
                           cellType: CartTableViewCell.self)) { row, model, cell in
                
                cell.viewModel.cartItem = [model.key:model.value]
            }.disposed(by: disposeBag)
        
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
                        self.activityIndicator.startAnimating()
                    case .loaded:
                        self.activityIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
