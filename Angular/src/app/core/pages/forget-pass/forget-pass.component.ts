import { Component } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-forget-pass',
  standalone: true,
  imports: [ReactiveFormsModule,RouterLink],
  templateUrl: './forget-pass.component.html',
  styleUrl: './forget-pass.component.css'
})
export class ForgetPassComponent {

  isCodeForm: boolean = false
  isNewPassForm: boolean = false
  errorMessage: string = ''
  isLoading: boolean = false

  emailForm: FormGroup = new FormGroup({
    email: new FormControl(null, [Validators.required, Validators.email])
  })

  CodeForm: FormGroup = new FormGroup({
    resetCode: new FormControl(null, [Validators.required])
  })

  newPassForm: FormGroup = new FormGroup({
    email: new FormControl(null, [Validators.required, Validators.email]),
    newPassword: new FormControl(null, [Validators.required, Validators.pattern(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$/)]),
  })

  constructor(private _AuthService: AuthService, private _Router: Router) { }

  verifyEmailBtn() {
    if (this.emailForm.invalid) {
      this.errorMessage = 'Please enter a valid email';
      return;
    }

    let userEmail = this.emailForm.get('email')?.value
    this.newPassForm.get('email')?.patchValue(userEmail)

    this.isLoading = true;
    this.errorMessage = '';

    this._AuthService.sendVerifyEmailApi(this.emailForm.value).subscribe({
      next: (res) => {
        console.log(res);

        if (res.statusMsg == "success") {
          this.isLoading = false;
          this.isCodeForm = true
        }
      },
      error: (err) => {
        console.error(err);
        this.isLoading = false;
        this.errorMessage = err.error.message || 'Failed to send email. Please try again.';
      }
    });
  }

  verifyCodeBtn() {
    if (this.CodeForm.invalid) {
      this.errorMessage = 'Please enter a valid code';
      return;
    }

    this.isLoading = true;
    this.errorMessage = '';

    this._AuthService.sendCodeApi(this.CodeForm.value).subscribe({
      next: (res) => {
        console.log(res);
        if (res.status == "Success") {
          this.isLoading = false;
          this.isCodeForm = false
          this.isNewPassForm = true
        }
      },
      error: (err) => {
        console.error(err);
        this.isLoading = false;
        this.errorMessage = err.error.message || 'Failed to send code. Please try again.';
      }
    });
  }


  newPasswordBtn() {
    if (this.newPassForm.invalid) {
      this.errorMessage = 'Please enter a valid password';
      return;
    }

    this.isLoading = true;
    this.errorMessage = '';

    this._AuthService.sendNewPasswordApi(this.newPassForm.value).subscribe({
      next: (res) => {
        console.log(res);
        this.isLoading = false;
        localStorage.setItem("userToken", res.token)
        this._AuthService.userInfo
        this._Router.navigate(['/login'])
        
      },
      error: (err) => {
        console.error(err);
        this.isLoading = false;
        this.errorMessage = err.error.message || 'Failed to send password. Please try again.';
      }
    });
  }


}


