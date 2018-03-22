import Foundation
import ObjectMapper

class UserData : Mappable {

    var email: String!
    var gender: String!
    
    var fbid: String!;
    var name1: String!;
    var name2: String!;
    var name3: String!;
    
    var national: String!;
    var bday: String!;
    var taj: String!;
    var avatar: String!;
    
    var phoneprefix: String!;
    var phoneprefixcode: String!;
    var phone: String!;
    var whatsapp: String!;
    var skype: String!;
    var facebook: String!;
    var snapchat: String!;
    var viber: String!;
    
    var blood: String!;
    var bloodrh: String!;
    var height: String!;
    var weight: String!;
    var allergy: String!;
    
    var langs: Array<LangModel>!;
    var allergies: Array<AllergyModel>!;
    var customallergies: Array<AllergyModel>!;
    var med: Array<MedModel>!;
    var medinfo: Array<MedicalModel>!;
    var pending : Array<PendingGuard>!;
    var doctors: Array<DoctorModel>!;
    var protecteds: Array<ProtectedModel>!;
    var guards: Array<UserData>!;
    
    var lat: String!;
    var lng: String!;
    var emcountry: String!;
    var emnumber: String!;
    var policenumber: String!;
    var firenumber: String!;
    var ambulancenumber: String!;
    var terrornumber: String!;
    
    var password: String!;
    var paid: Bool!;

    var soscall: Bool!;
    var sossms: Bool!;
    var sosemail: Bool!;
    var gsoscall: Bool!;
    var gsossms: Bool!;
    var gsosemail: Bool!;
    
    var policecall: Bool!;
    var policesms: Bool!;
    var gpolicecall: Bool!;
    var gpolicesms: Bool!;
    var gpoliceemail: Bool!;
    
    var firecall: Bool!;
    var firesms: Bool!;
    var gfirecall: Bool!;
    var gfiresms: Bool!;
    var gfireemail: Bool!;
    
    var ambcall: Bool!;
    var ambsms: Bool!;
    var gambcall: Bool!;
    var gambsms: Bool!;
    var gambemail: Bool!;
    
    var tacall: Bool!;
    var tasms: Bool!;
    var gtacall: Bool!;
    var gtasms: Bool!;
    var gtaemail: Bool!;
    
    var cantrack: Bool!;
    
    var asGcall: Bool!;
    var asGsms: Bool!;
    var asGemail: Bool!;
    var asGfacebook: Bool!;
    
    var firebaseid: String!;
    var name: String!;
    var avatarid: String!;
    var invitesended: Bool!;
    var accepted: Bool!;
    var rejected: Bool!;
    var registered: Bool!;
    var datasetuped: Bool!;
    
    var enabled: Bool!;
    
    var deviceID: String!;
    
    var home: String!;
    
    var zip: String!;
    var city: String!;
    var street: String!;
    var streetno: String!;
    var floordoor: String!;
 
    
    required init?(map: Map) {
        //super.init(map: map)
    }
    
    func safe(key: String) -> Any? {
        let copy = Mirror(reflecting: self)
        for child in copy.children.makeIterator() {
            if let label = child.label, label == key {
                return child.value
            }
        }
        return nil
    }
    
    func mapping(map: Map) {
        //super.mapping(map: map)
        fbid <- map["fbid"]
        name1 <- map["name1"]
        name2 <- map["name2"]
        name3 <- map["name3"]
        email <- map["email"]
        national <- map["national"]
        gender <- map["gender"]
        bday <- map["bday"]
        taj <- map["taj"]
        avatar <- map["avatar"]
        phoneprefix <- map["phoneprefix"]
        phoneprefixcode <- map["phoneprefixcode"]
        phone <- map["phone"]
        whatsapp <- map["whatsapp"]
        skype <- map["skype"]
        facebook <- map["facebook"]
        snapchat <- map["snapchat"]
        viber <- map["viber"]
        blood <- map["blood"]
        bloodrh <- map["bloodrh"]
        height <- map["height"]
        weight <- map["weight"]
        allergy <- map["allergy"]
        
        lat <- map["lat"]
        lng <- map["lng"]
        emcountry <- map["emcountry"]
        emnumber <- map["emnumber"]
        policenumber <- map["policenumber"]
        firenumber <- map["firenumber"]
        ambulancenumber <- map["ambulancenumber"]
        terrornumber <- map["terrornumber"]
        password <- map["password"]
        firebaseid <- map["firebaseid"]
        name <- map["name"]
        avatarid  <- map["avatarid"]
        deviceID  <- map["deviceID"]
        home <- map["home"]
        zip  <- map["zip"]
        city <- map["city"]
        street <- map["street"]
        streetno <- map["streetno"]
        floordoor <- map["floordoor"]
        paid <- map["paid"]
        soscall <- map["soscall"]
        sossms <- map["sossms"]
        gsoscall <- map["gsoscall"]
        gsossms <- map["gsossms"]
        sosemail <- map["sosemail"]
        policecall <- map["policecall"]
        policesms <- map["policesms"]
        gpolicecall <- map["gpolicecall"]
        gpolicesms <- map["gpolicesms"]
        gpoliceemail <- map["gpoliceemail"]
        firecall <- map["firecall"]
        firesms <- map["firesms"]
        gfirecall <- map["gfirecall"]
        gfiresms <- map["gfiresms"]
        gfireemail <- map["gfireemail"]
        ambcall <- map["ambcall"]
        ambsms <- map["ambsms"]
        gambcall <- map["gambcall"]
        gambsms <- map["gambsms"]
        gambemail <- map["gambemail"]
        tacall <- map["tacall"]
        tasms <- map["tasms"]
        gtacall <- map["gtacall"]
        gtasms <- map["gtasms"]
        gtaemail <- map["gtaemail"]
        cantrack <- map["cantrack"]
        asGcall <- map["asGcall"]
        asGsms <- map["asGsms"]
        asGemail <- map["asGemail"]
        asGfacebook <- map["asGfacebook"]
        invitesended <- map["invitesended"]
        accepted <- map["accepted"]
        rejected <- map["rejected"]
        registered <- map["registered"]
        datasetuped <- map["datasetuped"]
        enabled <- map["enabled"]
        langs <- map["langs"]
        allergies <- map["allergies"]
        customallergies <- map["customallergies"]
        med <- map["med"]
        medinfo <- map["medinfo"]
        pending <- map["pending"]
        doctors <- map["doctors"]
        protecteds <- map["protecteds"]
        guards <- map["guards"]
        
    }
    
    
    
    init(
        fbid: String = "",
        name1: String = "",
        name2: String = "",
        name3: String = "",
        email: String = "",
        gender: String = "",
        national: String = "",
        bday: String = "",
        taj: String = "",
        avatar: String = "",
        phoneprefix: String = "",
        phoneprefixcode: String = "",
        phone: String = "",
        whatsapp: String = "",
        skype: String = "",
        facebook: String = "",
        snapchat: String = "",
        viber: String = "",
        blood: String = "",
        bloodrh: String = "",
        height: String = "",
        weight: String = "",
        allergy: String = "",
        
        lat: String="",
        lng: String="",
        emcountry: String="",
        emnumber: String="",
        policenumber: String="",
        firenumber: String="",
        ambulancenumber: String="",
        terrornumber: String="",
        password: String="",
        firebaseid: String="",
        name: String="",
        avatarid: String="",
        deviceID: String="",
        home: String="",
        zip: String="",
        city: String="",
        street: String="",
        streetno: String="",
        floordoor: String="",
        paid: Bool = false,
        soscall: Bool = false,
        sossms: Bool = false,
        gsoscall: Bool = false,
        gsossms: Bool = false,
        sosemail: Bool = false,
        policecall: Bool = false,
        policesms: Bool = false,
        gpolicecall: Bool = false,
        gpolicesms: Bool = false,
        gpoliceemail: Bool = false,
        firecall: Bool = false,
        firesms: Bool = false,
        gfirecall: Bool = false,
        gfiresms: Bool = false,
        gfireemail: Bool = false,
        ambcall: Bool = false,
        ambsms: Bool = false,
        gambcall: Bool = false,
        gambsms: Bool = false,
        gambemail: Bool = false,
        tacall: Bool = false,
        tasms: Bool = false,
        gtacall: Bool = false,
        gtasms: Bool = false,
        gtaemail: Bool = false,
        cantrack: Bool = false,
        asGcall: Bool = false,
        asGsms: Bool = false,
        asGemail: Bool = false,
        asGfacebook: Bool = false,
        invitesended: Bool = false,
        accepted: Bool = false,
        rejected: Bool = false,
        registered: Bool = false,
        datasetuped: Bool = false,
        enabled: Bool = false,
        
        langs: Array<LangModel> = Array<LangModel>(),
        allergies: Array<AllergyModel> = Array<AllergyModel>(),
        customallergies: Array<AllergyModel> = Array<AllergyModel>(),
        med: Array<MedModel> = Array<MedModel>(),
        medinfo: Array<MedicalModel> = Array<MedicalModel>(),
        pending: Array<PendingGuard> = Array<PendingGuard>(),
        doctors: Array<DoctorModel> = Array<DoctorModel>(),
        protecteds: Array<ProtectedModel> = Array<ProtectedModel>(),
        guards: Array<UserData> = Array<UserData>()
        
     ) {
        
        //super.init()!
        
        self.fbid = fbid
        self.name1 = name1
        self.name2  = name2
        self.name3  = name3
        self.email = email
        self.national = national
        self.gender = gender
        self.bday = bday
        self.taj = taj
        self.avatar = avatar
        self.phoneprefix = phoneprefix
        self.phoneprefixcode = phoneprefixcode
        self.phone = phone
        self.whatsapp = whatsapp
        self.skype = skype
        self.facebook = facebook
        self.snapchat = snapchat
        self.viber = viber
        self.blood = blood
        self.bloodrh = bloodrh
        self.height = height
        self.weight = weight
        self.allergy = allergy
        
        self.lat = lat
        self.lng = lng
        self.emcountry = emcountry
        self.emnumber = emnumber
        self.policenumber = policenumber
        self.firenumber = firenumber
        self.ambulancenumber = ambulancenumber
        self.terrornumber = terrornumber
        self.password = password
        self.firebaseid = firebaseid
        self.name = name
        self.avatarid = avatarid
        self.deviceID = deviceID
        self.home = home
        self.zip = zip
        self.city = city
        self.street = street
        self.streetno = streetno
        self.floordoor = floordoor
        self.paid = paid
        self.soscall = soscall
        self.sossms = gsossms
        self.gsoscall = gsoscall
        self.gsossms = gsossms
        self.sosemail = sosemail
        self.policecall = policecall
        self.policesms = policesms
        self.gpolicecall = gpolicecall
        self.gpolicesms = gpolicesms
        self.gpoliceemail = gpoliceemail
        self.firecall = firecall
        self.firesms = firesms
        self.gfirecall = gfirecall
        self.gfiresms = gfiresms
        self.gfireemail = gfireemail
        self.ambcall = ambcall
        self.ambsms = ambsms
        self.gambcall = gambcall
        self.gambsms = gambsms
        self.gambemail = gambemail
        self.tacall = tacall
        self.tasms = tasms
        self.gtacall = gtacall
        self.gtasms = gtasms
        self.gtaemail = gtaemail
        self.cantrack = cantrack
        self.asGcall = asGcall
        self.asGsms = asGsms
        self.asGemail = asGemail
        self.asGfacebook = asGfacebook
        self.invitesended = invitesended
        self.accepted = accepted
        self.rejected = rejected
        self.registered = registered
        self.datasetuped = datasetuped
        self.enabled = enabled
    
        self.langs = langs
        self.allergies = allergies
        self.customallergies = customallergies
        self.med = med
        self.medinfo = medinfo
        self.pending = pending
        self.doctors = doctors
        self.protecteds = protecteds
        self.guards = guards
        
    }
}
