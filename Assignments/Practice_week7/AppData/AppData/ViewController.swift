import UIKit

class ViewController: UIViewController {

    let semaphore = DispatchSemaphore(value: 1)
    
    @IBAction func execute() {
        executeTest()
    }
    
    func executeTest() {
        let count = 100
        
        for index in 0..<count {
            semaphore.wait()
            AppData.shared.set(value: index, key: String(index))
            semaphore.signal()
        }
        
        DispatchQueue.concurrentPerform(iterations:count) { (index) in
            semaphore.wait()
            if let n = AppData.shared.object(key: String(index)) as? Int{
                print(n)
                semaphore.signal()
            }
        }
        
        semaphore.wait()
        AppData.shared.reset()
        semaphore.signal()
        
        DispatchQueue.concurrentPerform(iterations:count) { (index) in
            semaphore.wait()
            AppData.shared.set(value:index,key:String(index))
            semaphore.signal()
        }
    }
}

