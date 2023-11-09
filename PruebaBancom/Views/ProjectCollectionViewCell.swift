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
    }
    
    func configure(project: Project){
        avatarGroup.setAvatars(images: project.images)
        titleLabel.text = project.title
        dateLabel.text = project.date
        progresView.setProgress(project.progress, animated: false)
        
        progressLabel.text = String(Int(100*project.progress)) + "%"
    }
    
}
