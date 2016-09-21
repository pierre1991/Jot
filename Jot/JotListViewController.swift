//
//  JotListViewController.swift
//  Jot
//
//  Created by Pierre on 6/27/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import UIKit

class JotListViewController: UIViewController {

    
    //MARK: Singleton
    static let sharedController = JotListViewController()

    
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var composeBarButton: UIBarButtonItem!
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
		setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    

    
    
    
    //MARK: IBActions
	@IBAction func composeButtonTapped(_ sender: AnyObject) {
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JotComposeViewController")
        
		navigationController?.pushViewController(destinationViewController, animated: true)
    }

    

	
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toJotDetail" {
            if let detailVC = segue.destination as? JotComposeViewController {
                _ = detailVC.view
                
                if let selectedRow = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                    detailVC.updateWithJot(JotController.sharedController.jot.reversed()[selectedRow])
                }
            }
        }
    }
    
    
    func setupNavigationBar() {
        self.title = "jot"
        composeBarButton.image = UIImage(named: "compose_button")?.withRenderingMode(.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}



extension JotListViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JotController.sharedController.jot.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    	let cell = tableView.dequeueReusableCell(withIdentifier: "jotCell", for: indexPath) as! JotTableViewCell
        let jot = JotController.sharedController.jot.reversed()[(indexPath as NSIndexPath).row]
        
        cell.updateJot(jot)
        cell.selectionStyle = .none
        
        return cell
    }

	//MARK: Table View Delegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let jot = JotController.sharedController.jot[(indexPath as NSIndexPath).row]
            JotController.sharedController.deleteJot(jot)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
}
