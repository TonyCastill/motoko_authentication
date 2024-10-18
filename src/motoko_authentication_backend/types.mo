import Result "mo:base/Result";

module{
    public type Profile ={
        username : Text;
        email : Text;
    };
    //Para gregresar el perfil cuando existe
    public type GetProfileResultOk = Profile;

    // Para los dos tiposd de error
    public type GetProfileResultErr ={
        #userDoesNotExist;
        #userNotAuthenticated;
    };

    //Solo devuelve el resutado
    public type GetProfileResult = Result.Result<GetProfileResultOk, GetProfileResultErr>;
}