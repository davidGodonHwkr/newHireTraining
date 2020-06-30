//
//  InfoView.swift
//  NewHireProject
//
//  Created by Hoonie on 6/9/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorEmailLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    func fillLabels(rowSelected: Int?, posts: [Posts]) {
        if let row = rowSelected {
            let post: Posts! = posts[row]
            postNameLabel?.text = post.postName
            descriptionLabel?.text = post.postDescription
            dateLabel?.text = post.date
            authorNameLabel?.text = post.authorName
            authorEmailLabel?.text = post.authorEmail
            displayNameLabel?.text = post.displayName
        }
    }

}
