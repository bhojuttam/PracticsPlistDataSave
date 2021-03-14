//
//  TopFreeTableCell.swift
//  PracticalTask
//
//  Created by Uttam Bhoj on 08/03/21.
//

import UIKit
import SDWebImage
class TopFreeTableCell: UITableViewCell {

    @IBOutlet var viewBackground : UIView!
    @IBOutlet var imageBackgroud : UIImageView!
    @IBOutlet var imageLogo : UIImageView!
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblArtistName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBackground.layer.cornerRadius = 5.0
        self.viewBackground.layer.masksToBounds = true
    }

    func updateCell(_ objectFreeApp: TopFreeModel) {
        self.lblName.text = objectFreeApp.name
        self.lblArtistName.text = objectFreeApp.artistName
        self.imageLogo.sd_setImage(with: URL(string: objectFreeApp.logo))
        self.imageBackgroud.sd_setImage(with: URL(string: objectFreeApp.logo))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
