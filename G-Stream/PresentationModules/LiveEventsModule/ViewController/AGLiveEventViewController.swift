//
//  AGLiveViewController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import UIKit

class AGLiveEventViewController: BaseViewController{

    @IBOutlet weak var liveEventsTabelView: UITableView! {
        didSet{
            self.liveEventsTabelView.register(AGEventsLiveTableViewCell.self, forCellReuseIdentifier: "liveCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loawding the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Mark: - Initialiser Method
    final class func create() -> AGLiveEventViewController {
        let view = AGLiveEventViewController(nibName: "AGLiveEventViewController", bundle: nil)
        return view
    }

}

extension AGLiveEventViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0//reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liveCell", for: indexPath)
        //cell.reportTitle.text = reports[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pos = indexPath.row
        print(".........\(pos)......")
    }
}
