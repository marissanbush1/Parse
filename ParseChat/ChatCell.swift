//
//  ChatCell.swift
//  ParseChat
//
//  Created by Marissa Bush on 12/9/17.
//  Copyright © 2017 Marissa Bush. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatAuthorLabel: UILabel!
    @IBOutlet weak var chatTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
