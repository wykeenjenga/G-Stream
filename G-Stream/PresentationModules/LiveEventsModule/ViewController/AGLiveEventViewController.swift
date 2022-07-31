//
//  AGLiveViewController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//  Copyright © 2022 G-Stream. All rights reserved.
//

import UIKit
import Kingfisher

class AGLiveEventViewController: BaseViewController{

    @IBOutlet weak var liveEventsTable: UITableView! {
        didSet{
            liveEventsTable.register(AGLiveEventViewCell.self)
            liveEventsTable.backgroundColor = .clear
        }
    }
    
    var viewModel: AGLiveViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.triggerGetAllLiveEvents()
        
        liveEventsTable.dataSource = self
        liveEventsTable.delegate = self
        
        UserDefaults.standard.set(true, forKey: "isOnboarding")
    }
    
    static func getLiveEvents() -> (DataEndpoint<AGLiveEvents>) {
        return DataEndpoint(path: "getEvents")
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if let count = self.viewModel.eventsData.value?.liveEvents?.count, count > 1 {
                let indexPath = IndexPath(row: count - 1, section: 0)
                self.liveEventsTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        bindToViewModel()
        
        liveEventsTable.reloadData()
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

            self?.liveEventsTable.reloadData()
        }
    
    }
    

    final class func create(with viewModel: AGLiveViewModel) -> AGLiveEventViewController {
        let view = AGLiveEventViewController(nibName: "AGLiveEventViewController", bundle: nil)
        view.viewModel = viewModel
        return view
    }

}

extension AGLiveEventViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.eventsData.value?.liveEvents?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView[AGLiveEventViewCell.self, indexPath]
        let event = viewModel.eventsData.value?.liveEvents?[indexPath.row]
        
        cell.league.text = event?.league
        cell.teams.text = event?.team
    
        let date = ConvertDate.convert(dt: event?.date! ?? "")
        cell.time.text = "\(date)"
        
        let url = URL(string: event?.imageUrl ?? "")!
        cell.leagueImage.setImageUrl(url: url)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pos = indexPath.row
        
        let event = viewModel.eventsData.value?.liveEvents?[pos]
        
        let liveStreamUrl = event?.videoUrl
        
        let videoPlayer = AGAppPlayer()
        StreamingVideoURL.videoUrl = liveStreamUrl!
        self.present(videoPlayer, animated: true, completion: nil)
    }
}

