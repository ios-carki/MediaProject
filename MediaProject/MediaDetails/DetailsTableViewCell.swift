//
//  DetailsTableViewCell.swift
//  MediaProject
//
//  Created by Carki on 2022/08/06.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actorImageView: UIImageView!
    
    @IBOutlet weak var actorRoleLabel: UILabel!
    @IBOutlet weak var inMediaName: UILabel!
    
    @IBOutlet weak var actorJobLael: UILabel!
    @IBOutlet weak var actorRealName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
