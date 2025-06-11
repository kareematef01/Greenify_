import { HttpClient } from '@angular/common/http';
import { Inject, Injectable, PLATFORM_ID } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
import { Environment } from '../../../Base/environment/environment';
import { login, Register } from '../../../shared/interfaces/register';
import { jwtDecode } from 'jwt-decode';
import { Router } from '@angular/router';
import { isPlatformBrowser } from '@angular/common';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  userData :BehaviorSubject<any> = new BehaviorSubject(null)
  constructor(private _HttpClient: HttpClient,private _Router:Router, @Inject(PLATFORM_ID) private platForm: object) {
    if(isPlatformBrowser(platForm)){
      if(localStorage.getItem("userToken")){
        console.log("hello from service");
        this.userInfo()
      }
    }
  }

  sendRegister(data: Register): Observable<any> {
    return this._HttpClient.post(`${Environment.baseUrl}/api/v1/auth/signup`, data)
  }

  sendLogin(data: login): Observable<any> {
    return this._HttpClient.post(`${Environment.baseUrl}/api/v1/auth/signin`, data)
  }

  userInfo() {
    this.userData.next(jwtDecode(JSON.stringify(localStorage.getItem("userToken")))) ;
    console.log(this.userData.getValue());
  }

  signout() {
    localStorage.removeItem("userToken")
   this.userData.next(null)
   this._Router.navigate(['/login'])
  }

  sendVerifyEmailApi(data: any): Observable<any> {
    return this._HttpClient.post(`${Environment.baseUrl}/api/v1/auth/forgotPasswords`, data)
  }

  sendCodeApi(data: any): Observable<any> {
    return this._HttpClient.post(`${Environment.baseUrl}/api/v1/auth/verifyResetCode`, data)
  }

  sendNewPasswordApi(data: any): Observable<any> {
    return this._HttpClient.put(`${Environment.baseUrl}/api/v1/auth/resetPassword`, data)
  }




}
