import { Component } from '@angular/core';
import { FormControl, FormGroup,ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [ReactiveFormsModule,RouterLink],
  templateUrl: './register.component.html',
  styleUrl: './register.component.css'
})
export class RegisterComponent {
  errorMessage: string = ''
  successMessage: string = ''
  isLoading: boolean = false

  registerForm: FormGroup = new FormGroup({
    name: new FormControl(null, [Validators.required, Validators.minLength(3), Validators.maxLength(20)]),
    email: new FormControl(null, [Validators.required, Validators.email]),
    password: new FormControl(null, [Validators.required, Validators.pattern(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$/)]),
    rePassword: new FormControl(null, [Validators.required, Validators.pattern(/^[A-Z][A-Za-z0-9]{6,}$/)]),
    phone: new FormControl(null, [Validators.required, Validators.pattern(/^01[0125][0-9]{8}$/)])

  }, this.confirmPassword)



  constructor(private _AuthService: AuthService, private _Router: Router) { }

  registerSubmit() {
    this.isLoading = true
    // console.log(this.registerForm.value)
    this._AuthService.sendRegister(this.registerForm.value).subscribe({
      next: (response) => {
        this.isLoading = false
        console.log(response);
        this.successMessage = response.message + " register"
        this._Router.navigate(['/login']);
      },
      error: (err) => {
        console.error(err);
        this.isLoading = false
        this.errorMessage = err.error.message || "Registration failed. Please try again.";
      }
    })


  }

  confirmPassword(g: any) {
    if (g.get('password').value === g.get('rePassword').value) {
      return null
    } else {
      return { 'mismatch': true }
    }
  }

}
