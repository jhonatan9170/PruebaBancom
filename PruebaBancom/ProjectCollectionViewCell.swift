//
//  ProjectCollectionViewCell.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 7/11/23.
//

import UIKit
import AvatarGroup

class ProjectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progresView: UIProgressView!
    @IBOutlet weak var avatarGroup: AvatarGroupView!


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarGroup.alignment = .left
        avatarGroup.backgroundColor = .clear
        avatarGroup.borderColor = .clear
        avatarGroup.setAvatars(images: [UIImage(named: "icon_google") ,UIImage(named: "icon_google"),UIImage(named: "icon_google")])
    }

}
