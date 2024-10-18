import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";

//Módulos custom
import Types "./types";

// type Result<Ok, Err> = {#ok: Ok; #err : Err};

actor {

    
    let profiles = HashMap.HashMap<Text, Types.Profile>(5, Text.equal, Text.hash);

    public func addProfile(newProfile : Types.Profile) : () {
        profiles.put(newProfile.username,newProfile);
    };

    public query func getProfiles() : async [Types.Profile] {
        let profileIter = profiles.vals(); // Es un query, pero esta variable no es global, por lo que se puede hacer esto 
        return Iter.toArray(profileIter);
    };
    
    public query (msg) func whoIAm(): async Principal{
        //Regresa la entidad que solicita el canister
        // es decir, el usuario que mandó a llamar 
        return msg.caller;
    };

    

    public query (msg) func getProfile(username:Text): async Types.GetProfileResult{
        
        if(Principal.isAnonymous(msg.caller)) return #err(#userNotAuthenticated);
        
        let maybeProfile = profiles.get(username);

        switch(maybeProfile){
            case(null){ #err(#userDoesNotExist)};
            case(?profile ) {#ok(profile)}; //maybeProfile se renombra como profile para ser enviado 
        }
    }
}