//
//  TaskTableViewCell.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 7/11/23.
//

import UIKit
import SimpleCheckbox
class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doneCheck: Checkbox!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneCheck.checkedBorderColor = .cyan
        doneCheck.uncheckedBorderColor = .darkGray
        doneCheck.checkmarkColor = .cyan
        doneCheck.checkboxFillColor = .clear
        doneCheck.checkmarkStyle = .tick
        doneCheck.borderStyle = .circle
        timeLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

        doneCheck.valueChanged = { (isChecked) in
            print("checkbox is checked: \(isChecked)")
        }
    }
    
    func configure(task: Post){
        timeLabel.text = String(Int.random(in: 2...9))+" hours"
        titleLabel.text = task.title
    }
}
