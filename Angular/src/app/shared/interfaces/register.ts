export interface login{
    email:string;
    password:string;
}

export interface Register extends login {
    name:string ;
    repassword:string;
    phone:string;
}