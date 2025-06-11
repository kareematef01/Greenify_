import { Component } from '@angular/core';
import { AuthService } from '../../core/services/auth/auth.service';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-settings',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './settings.component.html',
  styleUrl: './settings.component.css'
})
export class SettingsComponent {
  constructor(private _authService:AuthService){}
    
    logOut(){
      this._authService.signout()
    }
}
