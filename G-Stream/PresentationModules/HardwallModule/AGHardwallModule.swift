//
//  ViewController.swift
//  G-Stream
//
//  Created by Wykee Njenga on 7/28/22.
//

import UIKit

class AGHardwallModule: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var footTitle: UILabel!
    @IBOutlet var footNote: UILabel!
    
    @IBOutlet var vONE: UIView!
    @IBOutlet var vTWO: UIView!
    @IBOutlet var vTHREE: UIView!
    
    @IBOutlet weak var getStartedBtn: UIButton!
    
    var pos = 0
    
    let titles: [String] = [OnboardingTitles.stream, OnboardingTitles.schedule, OnboardingTitles.fans]
    
    let footNotes: [String] = [OnboardingSubTitles.stream, OnboardingSubTitles.schedule, OnboardingSubTitles.fans]
    
    let images = [OnboardingImages.stream, OnboardingImages.schedule, OnboardingImages.fans]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.image.image = images[0]
        self.footTitle.text = titles[0]
        self.footNote.text = footNotes[0]
    }

    @IBAction func login(_ sender: Any) {
        print("login")
    }
    
    @IBAction func getStarted(_ sender: Any) {
        print("Get Started")
        Accessors.AppDelegate.delegate.navigateToHome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.animateViews()
        self.initSwipe()
        self.getStartedBtn.isEnabled = false
    }
    
    func initSwipe(){
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onBoardingSwipeMade(_:)))
        leftRecognizer.direction = .left
        
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onBoardingSwipeMade(_:)))
        rightRecognizer.direction = .right
        self.view.addGestureRecognizer(leftRecognizer)
        self.view.addGestureRecognizer(rightRecognizer)
    }
    
    @IBAction func onBoardingSwipeMade(_ sender: UISwipeGestureRecognizer) {
       if sender.direction == .left {
           self.pos = self.pos + 1
           if pos > 2 {
               pos = 2
           }else{
               self.setOnBoardingValues(pos: pos)
           }
           
           if pos == 2{
               self.getStartedBtn.isEnabled = true
           }
       }
        
       if sender.direction == .right {
           self.pos = self.pos - 1
           if pos < 0 {
               pos = 0
           }else{
               self.setOnBoardingValues(pos: pos)
           }
       }
    }
    
    func setOnBoardingValues(pos: Int){
        self.image.image = images[pos]
        self.footTitle.text = titles[pos]
        self.footNote.text = footNotes[pos]
        self.observerIndicator()
        self.animateViews()
    }
    
    func observerIndicator(){
        switch self.pos{
        case 0:
            self.vTWO.backgroundColor = UIColor(named: "white")
            self.vTHREE.backgroundColor = UIColor(named: "white")
            self.vONE.backgroundColor = UIColor(named: "orange")
            
        case 1:
            self.vONE.backgroundColor = UIColor(named: "white")
            self.vTHREE.backgroundColor = UIColor(named: "white")
            self.vTWO.backgroundColor = UIColor(named: "orange")
        case 2:
            self.vONE.backgroundColor = UIColor(named: "white")
            self.vTWO.backgroundColor = UIColor(named: "white")
            self.vTHREE.backgroundColor = UIColor(named: "orange")
        default:
            break
        }
    }
    
    func animateViews(){
        UIView.animate(withDuration: 0.0) {
            self.image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
         }
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: [], animations: {
            self.footTitle.center.y += 30.0
            self.footTitle.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: [], animations: {
            self.image.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.image.alpha = 1.0
        }, completion: nil)
    }

    
}


