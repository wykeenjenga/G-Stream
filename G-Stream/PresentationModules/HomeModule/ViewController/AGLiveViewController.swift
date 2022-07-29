//
//  AGLiveViewController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import UIKit

class AGLiveViewController: UIViewController {

    @IBOutlet var liveTabelView: UITableView! {
        didSet{
            liveTabelView.register(AGLiveTableViewCell.self, forCellReuseIdentifier: "AGLiveTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loawding the view.
    }

}

extension AGLiveViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView[AGLiveTableViewCell.self, indexPath]
        //cell.reportTitle.text = reports[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pos = indexPath.row
        print(".........\(pos)......")
    }
}
