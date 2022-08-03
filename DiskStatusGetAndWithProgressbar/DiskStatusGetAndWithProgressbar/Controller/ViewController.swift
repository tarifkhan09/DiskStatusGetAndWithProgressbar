//
//  ViewController.swift
//  DiskStatusGetAndWithProgressbar
//
//  Created by MD Tarif khan on 3/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diskStatusCircle: ProgressBar!
    @IBOutlet weak var circelView: UIView!
    @IBOutlet weak var diskInfoLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circelView.layer.cornerRadius = (circelView.frame.size.width)/2
        self.circelView.applyGradientForView(colors: [UIColorFromRGB(0x47509a).cgColor,UIColorFromRGB(0x6771e6).cgColor])
        updateDiskStatus()

    }

    
    var countFired: CGFloat = 0
    private func showCase(totalMemory: Float, freeSpace: Float) {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { (timer) in
            self.countFired += 1
            
            DispatchQueue.main.async {
                self.diskStatusCircle.progress = min(CGFloat(0.01 * self.countFired), 1)
                
                if self.diskStatusCircle.progress >= CGFloat((freeSpace/totalMemory)) {
                    timer.invalidate()
                }
            }
        }
    }
    

    
    func updateDiskStatus() {
        let usedDiskSpace = String(format:NSLocalizedString("%@", comment: ""), DiskStatus.usedDiskSpace)
        let totalDiskSpace = String(format:NSLocalizedString("%@", comment: ""), DiskStatus.totalDiskSpace)
        let freeDiskSpace = String(format:NSLocalizedString("%@", comment: ""), DiskStatus.freeDiskSpace)
        
        ///remove space and last two character
        let usedMemorySpace = usedDiskSpace.trimmingCharacters(in: [" ","G","B"])
        let totalMemorySpace = totalDiskSpace.trimmingCharacters(in: [" ","G","B"])
        //        let freeMemorySpace = freeDiskSpace.trimmingCharacters(in: [" ","G","B"])
        
        let used  = (usedMemorySpace as NSString).floatValue
        let total = (totalMemorySpace as NSString).floatValue
        //        let free = (freeMemorySpace as NSString).floatValue
        
        if total <= 32{
            diskInfoLabel.text = "\(usedMemorySpace) of 32 GB"
            showCase(totalMemory: Float(32), freeSpace: Float(used))
        }
        else if total <= 64{
            diskInfoLabel.text = "\(usedMemorySpace) of 64 GB"
            showCase(totalMemory: Float(64), freeSpace: Float(used))
            
        }
        else if total <= 128{
            diskInfoLabel.text = "\(usedMemorySpace) of 128 GB"
            showCase(totalMemory: Float(128), freeSpace: Float(used))
            
        }
        else if total <= 256{
            diskInfoLabel.text = "\(usedMemorySpace) of 256 GB"
            showCase(totalMemory: Float(256), freeSpace: Float(used))
            
        }
        else if total <= 512{
            diskInfoLabel.text = "\(usedMemorySpace) of 512 GB"
            showCase(totalMemory: Float(512), freeSpace: Float(used))
            
        }
        
    }


}


extension UIView {
    func applyGradientForView(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
