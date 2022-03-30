import UIKit

//var greeting = "Hello, playground"


func sockMerchant(n: [Int])-> Int {

    var matchSock = 0
    var counts: [Int: Int] = [:]

    for item in n {
        counts[item] = (counts[item] ?? 0) + 1
    }

    print(counts, "\n")

    for (key, value) in counts {
        
        if value % 2 == 1 {
            if (value > 1) {
                print("(\(key)) has \((value-1)/2) pair(s).")
                }
            matchSock += (value-1)/2
        }
        if value % 2 == 0 {
            if (value > 1) {
                print("(\(key)) has \(value/2) pair(s).")
                }
            matchSock += value/2
        }
        
    }


    return matchSock
}

let sockCheck = sockMerchant(n: [1,1,1,1,1,1,1,1,1,5,5,6,6,6,6,6,1,1,2,3,4,4,100,100,100,100,100,100,100,100,100,100,100,100])
print("Total # of matching pairs: \(sockCheck)")



