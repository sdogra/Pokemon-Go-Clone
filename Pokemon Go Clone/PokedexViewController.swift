//
//  PokedexViewController.swift
//  Pokemon Go Clone
//
//  Created by Sahil Dogra on 7/11/19.
//  Copyright © 2019 Sahil Dogra. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    
}
