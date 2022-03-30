import UIKit

func twoStrings(word1 s1: String, word2 s2: String) -> Bool {
    
    var matches = 0
    var letters = ""
    var letterIndex = 0
    var isMatch = false
    var verify = false
    
    
    let arr = s1.map { String($0) }

    print("Array: \(arr)")
    letters = ""
    for char in arr {
        
        verify = s2.localizedCaseInsensitiveContains(char)  //checkin s1 to s2
        
        if s2.contains(char) {    //checkin s1 to s2 - not perfect though
            letters.append(char)
            matches += 1
        }
    }
    print("Letters: \(letters)")
    print("Verify: \(verify)")
    
    
    if letters.count > 1 {
        isMatch = true
    }
    
    return isMatch
}

let check = twoStrings(word1: "balloon flies high", word2: "My balloon is the best!")
print(check)
