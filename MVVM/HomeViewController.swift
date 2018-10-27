//
//  HomeViewController.swift
//  MVVM
//
//  Created by Ratheesh on 23/10/18.
//  Copyright © 2018 Ratheesh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchItems()
        // Do any additional setup after loading the view.
    }
    
    private func fetchItems() {
        
        viewModel.getApiData { [weak self] (data) in
            
            guard let weakSelf = self else { return }
            
            DispatchQueue.main.async {
                weakSelf.activity.stopAnimating()
                weakSelf.tableView.isHidden = false
                weakSelf.tableView.reloadData()
                
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        debugPrint("HomeViewController - deallocated")
    }


}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeCell, viewModel.items?.count ?? 0 > indexPath.row, let model = viewModel.items?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(model)
        
        return cell
    }
}
