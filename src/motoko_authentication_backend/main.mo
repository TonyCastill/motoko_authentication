actor {
  /*
    (msg)
    On ICP, a canister can selectively inspect,
    then choose to accept or decline ingress
    messages submitted through the HTTP interface.

    (msg) es información del contexto de quién se
    manda a llamar 
  */


  // Estructura de (msg)
  type Message ={
    caller:Principal;
  };


  // Con msg, se puede retorna un Principal
  //  que puede representar una entidad como una identidad

  //Principal es un identificador
  // En este caso devuelve el identificador de quién está
  // ejecutando un smart contract o un canister

  // Cuando alguien no está autenticado, siempre enviará
  // el mismo tipo de dato

  //Para entrar como un usuario autenticado, se debe ingresar
  // a la URL del backend de motoko y agregar un & con la identidad
  // URL&ii=id_internet_identity
  // URL&ii=http://bkyz2-fmaaa-aaaaa-qaaaq-cai.localhost:4943/

  // Llamar funciones desde la consola
  // dfx canister call nombre_canister funcion_canister
  // dfx canister call motoko_authentication_backend whoAmI

  // Conseguir principal desde consola (resultado es el administrador o dev)
  // dfx identity whoami
  // dfx identity get-principal
  public query (msg) func whoAmI() : async Principal {
      return msg.caller;
  };

  /*
    Cuando se ejecutan los dos canisters, se lanza un
    canister de frontend por defecto con dos URL
    para el internet identity
  */

  var name: Text = "";

  public query (msg) func getName() : async Text{
    return "Hello, "# name
  };


  public query (msg) func greet(name : Text) : async Text {
    // Says hello
    return "Hello, " # name # "!";
  };


  //shared siempre está implícita en todas las funciones

  //En los métodos update, se necesita agregar shared para usar (msg)
  public shared (msg) func setName(newname:Text) : async (){
    name:= newname;
  }; 

};
