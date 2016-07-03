/** 
 Interview Cake problem 11
 **/
import Foundation

protocol Crawler {
    associatedtype UrlStorageType: Hashable
    var urlsVisited: Set<UrlStorageType> { get set }
    
    func haveVisited(_ url: String) -> Bool
    mutating func storeUrl(_ url: String)
}


struct HashingCrawler: Crawler {
    internal var urlsVisited = Set<Int>()
    
    func haveVisited(_ url: String) -> Bool {
        return urlsVisited.contains(url.hashValue)
    }
    
    mutating func storeUrl(_ url: String) {
        urlsVisited.insert(url.hashValue)
    }
}

struct StorageCrawler: Crawler {
    internal var urlsVisited = Set<String>()
    
    func haveVisited(_ url: String) -> Bool {
        return urlsVisited.contains(url)
    }
    
    mutating func storeUrl(_ url: String) {
        urlsVisited.insert(url)
    }
}

let urls = ["http://www.altpress.org/",
            "http://www.nzfortress.co.nz",
            "http://www.evillasforsale.com",
            "http://www.playingenemy.com/",
            "http://www.richardsonscharts.com",
            "http://www.xenith.net",
            "http://www.tdbrecords.com",
            "http://www.electrichumanproject.com/",
            "http://tweekerchick.blogspot.com/",
            "http://www.besound.com/pushead/home.html",
            "http://www.porkchopscreenprinting.com/",
            "http://www.kinseyvisual.com",
            "http://www.rathergood.com",
            "http://www.lepoint.fr/",
            "http://www.revhq.com",
            "http://www.poprocksandcoke.com",
            "http://www.samuraiblue.com/",
            "http://www.openbsd.org/cgi-bin/man.cgi",
            "http://www.sysblog.com",
            "http://www.voicesofsafety.com",
            "http://www.lambgoat.com/",
            "http://paul.kedrosky.com/",
            "http://www.sallyskrackers.com",
            "http://www.starmen.net",
            "http://www.casbahmusic.com/",
            "http://www.bowlingshirt.com",
            "http://www.ems.org/",
            "http://www.primedeep.com",
            "http://www.lovehammers.com/",
            "http://www.lifehacker.com",
            "http://danklife.com",
            "http://www.whichisworse.com",
            "http://www.getmusic.com/",
            "http://www.apple.com/support/",
            "http://www.brunching.com/toys/toy-alanislyrics.html",
            "http://www.loftkoeln.de/loftframes.html",
            "http://www.monoroid.com",
            "http://www.diyordie.com",
            "http://you.alterFin.org/",
            "http://www.atarimagazines.com/",
            "http://www.reforms.net",
            "http://screwattack.com/",
            "http://www.gaijinagogo.com",
            "http://www.yarrah.com",
            "http://mock.alterfin.org/",
            "http://www.funxiun.com/",
            "http://www.cbwgaming.com",
            "http://www.ickle.org/",
            "http://www.shadowburn.com/forum",
            "http://www.seifried.org/oag/",
            "http://www.alternet.org",
            "http://www.sbpost.ie/",
            "http://www.kuro5hin.org",
            "http://www.groovechamber.com/cnh.htm",
            "http://www.redstream.org/",
            "http://www.notfoolinganybody.com/",
            "http://southparkstudios.com/games/create.html",
            "http://www.guardian.co.uk/",
            "http://www.securityfocus.com/",
            "http://www.acidtwist.com/"]

var c1 = HashingCrawler()
for url in urls {
    c1.storeUrl(url)
}

var c2 = StorageCrawler()
for url in urls {
    c2.storeUrl(url)
}

print(sizeofValue(c1))
print(sizeofValue(c2))
