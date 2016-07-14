
import Foundation

// Here's some machinery to make fake files for testing

struct FakeFile: Hashable {
    var path: String
    var contents: [Int]
    
    var hashValue: Int {
        var hash = 0
        for (index, value) in contents.enumerated() {
            hash += (index + 1) * value
        }
        return hash
    }
}

struct FilePaths: CustomStringConvertible {
    var duplicate: String
    var original: String
    
    var description: String {
        return "(original: \(original), duplicate: \(duplicate))"
    }
}

func ==(lhs: FakeFile, rhs: FakeFile) -> Bool {
    return lhs.contents == rhs.contents
}

func randomInt() -> Int {
    return Int(arc4random())
}

func randomStringOf(length: Int) -> String {
    let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var c = charSet.characters.filter { $0 != nil }
    var s = ""
    for _ in 1...length {
        s.append(c[Int(arc4random()) % c.count])
    }
    return s
}

func randomIntArrayOf(length: Int) -> [Int] {
    var ints = [Int]()
    for _ in 1...length {
        ints.append(randomInt())
    }
    return ints
}

randomStringOf(length: 5)

var files = [FakeFile]()

// create 100 files
for _ in 1...100 {
    files.append(FakeFile(path: randomStringOf(length: 20), contents: randomIntArrayOf(length: 20)))
}

var dup1 = files[3]
dup1.path = "duplicate 1"
files.append(dup1)

var dup2 = files[30]
dup2.path = "duplicate 2"
files.append(dup2)

// there are now two duplicate files, let's see if we can find them

// Given a list of hashable items, returns array of duplicated files
func findDuplicateFiles(files: [FakeFile]) -> [FilePaths] {
    var fileAndHash = [Int: String]()
    var duplicates = [FilePaths]()
    
    for file in files {
        let hash = file.hashValue
        if fileAndHash.keys.contains(hash) {
            duplicates.append(FilePaths(duplicate: file.path, original: fileAndHash[hash]!))
        } else {
            fileAndHash[hash] = file.path
        }
    }
    
    return duplicates
}

print(findDuplicateFiles(files: files))
