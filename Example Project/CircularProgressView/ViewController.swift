//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Sven Bacia on 01/08/15.
//  Copyright © 2015 Sven Bacia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var progressView: CircularProgressView!

  @IBAction func progress() {
    progressView.setProgress(1.0, animated: true)
  }
  
  @IBAction func reset() {
    progressView.setProgress(0.0, animated: true)
  }
  
  @IBAction func changeCapStyle(sender: UISegmentedControl) {
    
    var lineCap: LineCap = progressView.lineCap
    
    switch sender.selectedSegmentIndex {
    case 0:
      lineCap = .Round
    case 1:
      lineCap = .Butt
    case 2:
      lineCap = .Square
    default:
      lineCap = .Round
    }
    
    progressView.lineCap = lineCap
  }
  
}

