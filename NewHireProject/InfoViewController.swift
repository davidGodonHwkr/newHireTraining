//
//  InfoViewController.swift
//  NewHireProject
//
//  Created by Hoonie on 6/9/20.
//  Copyright © 2020 HWKR. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var rowSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let infoView = Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)?.first as? InfoView {
            infoView.fillLabels(rowSelected: rowSelected)
            self.view.addSubview(infoView)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
