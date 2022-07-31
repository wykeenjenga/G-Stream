//
//  AGScheduleViewController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/29/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import UIKit

class AGScheduleViewController: BaseViewController {
    
    @IBOutlet weak var scheduledTableView: UITableView! {
        didSet{
            scheduledTableView.register(AGLiveEventViewCell.self)
            scheduledTableView.backgroundColor = .clear
        }
    }
    
    var viewModel: AGScheduledViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getScheduledEvents()

        scheduledTableView.dataSource = self
        scheduledTableView.delegate = self
    }

    final class func create(with viewModel: AGScheduledViewModel) -> AGScheduleViewController {
        let view = AGScheduleViewController(nibName: "AGScheduleViewController", bundle: nil)
        view.viewModel = viewModel
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        bindToViewModel()
        
        scheduledTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func bindToViewModel() {
        
        self.viewModel.route.bind = {[weak self] route in
            DispatchQueue.main.async {
                switch route {
                case .error:
                    self?.showAlert()
                case .back:
                    self?.dismiss(animated: true, completion: nil)
                    
                case .activity(let status):
                    if status{
                        self?.showHUD()
                    }else{
                        self?.hideHUD()
                    }
                    break
                default:
                    break
                }
            }
        }

        self.viewModel.eventsData.bind = { [weak self] _ in
            self?.scheduledTableView.reloadData()
        }
    
    }
}


extension AGScheduleViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.eventsData.value?.scheduledEvents?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView[AGLiveEventViewCell.self, indexPath]
        let event = viewModel.eventsData.value?.scheduledEvents?[indexPath.row]
        
        cell.league.text = event?.league
        cell.teams.text = event?.team
        cell.time.text = event?.date
        
        let url = URL(string: event?.imageUrl ?? "")!
        cell.leagueImage.setImageUrl(url: url)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pos = indexPath.row
        
        let event = viewModel.eventsData.value?.scheduledEvents?[pos]
        
    }
}
