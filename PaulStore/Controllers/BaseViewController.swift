//
//  BaseViewController.swift
//  PaulStore
//
//  Created by 連振甫 on 2021/8/31.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    var spinnerView:UIView!
    var topItemTitle = ""
    var isLargeTitles = false
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TODO: setup navigationController
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        //TODO: setup spinner view
        spinnerView = UIView()
        spinnerView.frame.size = CGSize(width: 100, height: 100)
        spinnerView.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        spinnerView.layer.cornerRadius = 10
        spinnerView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(spinnerView)
        
        
        let label = UILabel()
        label.frame.size = CGSize(width: spinnerView.bounds.width, height: 30)
        label.center = CGPoint(x: spinnerView.frame.width/2, y: spinnerView.frame.height/2)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Loading..."
        label.font = label.font.withSize(8)
        spinnerView.addSubview(label)
        
        let activityIndicatorView = NVActivityIndicatorView(frame: spinnerView.bounds, type: .circleStrokeSpin, color: .green, padding: 20)
        spinnerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
        spinnerView.isHidden = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = topItemTitle
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.bringSubviewToFront(spinnerView)
    }
    
    func startSpinner() {
        DispatchQueue.main.async {
            self.spinnerView.isHidden = false
        }
    }
    
    func stopSpinner() {
        DispatchQueue.main.async {
            self.spinnerView.isHidden = true
        }
    }
}
