//
//  JotTableViewCell.swift
//  Jot
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import UIKit

class JotTableViewCell: UITableViewCell {

    
    //MARK: IBOutlets
    @IBOutlet weak var customCellView: UIView!
    @IBOutlet weak var jotLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
	
    func updateJot(_ jot: Jot) {
    	jotLabel.text = jot.body
        
        customCellView.layer.cornerRadius = 6.0
    }
}
