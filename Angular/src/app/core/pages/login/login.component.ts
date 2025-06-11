import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { AuthService } from '../../services/auth/auth.service';
import { Router, RouterLink } from '@angular/router';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [ReactiveFormsModule,RouterLink],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  errorMessage: string = ''
  isLoading: boolean = false

  loginForm: FormGroup = new FormGroup({
    email: new FormControl(null, [Validators.required, Validators.email]),
    password: new FormControl(null, [Validators.required, Validators.pattern(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$/)]),
  })



  constructor(private _AuthService: AuthService, private _Router: Router) { }

  loginSubmit() {
    this.isLoading = true
    // console.log(this.loginForm.value)
    this._AuthService.sendLogin(this.loginForm.value).subscribe({
      next: (res) => {
        this.isLoading = false
        console.log(res);
        localStorage.setItem("userToken", res.token)

        this._AuthService.userInfo()

        this._Router.navigate(['/home']);
      },
      error: (err) => {
        console.error(err);
        this.isLoading = false
        this.errorMessage = err.error.message || "login failed. Please try again.";
      }
    })


  }


}
