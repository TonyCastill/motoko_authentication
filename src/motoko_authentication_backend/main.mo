import Principal "mo:base/Principal";
import Result "mo:base/Result"; // Para retornar resultados ante las validaciones
//https://internetcomputer.org/docs/current/motoko/main/base/Result
import Text "mo:base/Text";

// type Result<Ok, Err> = {#ok: Ok; #err : Err};

actor {
    public query (msg) func whoIAm(): async Principal{
        //Regresa la entidad que solicita el canister
        // es decir, el usuario que mandó a llamar 
        return msg.caller;
    };


    public query (msg) func greet(): async Result.Result<Text,Text>{
        // Verifica si el usuario está autenticado
        if (Principal.isAnonymous(msg.caller )) return #err("No tienes acceso");
        
        //Si está autenticado, retorna esto
        return #ok("Hello world");
    }
}