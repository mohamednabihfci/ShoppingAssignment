//
//  HomeViewController.swift
//  ShoppingAssignment
//
//  Created by AboNabih on 7/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //MARK: Variable
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Cars"
        setupNibFiles()
        setupRxBindings()
        viewModel.getCars()
    }
    //MARK: Method
    func setupNibFiles() {
        tableView.registerCellNib(cellClass: HomeTableViewCell.self)
    }
    func setupRxBindings() {
        ShoppingCart.sharedCart.cartItems.asObservable().observe(on: MainScheduler())
          .subscribe(onNext: { [weak self] items in
              ShoppingCart.sharedCart.saveData()
              let count = items.values.reduce(0, +)
              self?.tabBarController?.tabBar.items?.last?.badgeValue = count > 0 ? "\(count)" : nil
          })
          .disposed(by: disposeBag)
        
        viewModel.cars
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: HomeTableViewCell.Identifier,
                           cellType: HomeTableViewCell.self)) { row, model, cell in
                cell.viewModel.car.accept(model)
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
