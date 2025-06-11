import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { AuthService } from '../../../core/services/auth/auth.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [RouterLink,RouterLinkActive],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {
  isLoggedIn:boolean = false

  constructor(private _authService:AuthService){
    _authService.userData.subscribe(res=>{
      console.log("hello from Navbar", res);
      if(res){
        this.isLoggedIn = true
      }else{
        this.isLoggedIn = false
      }
    })
    
  }

  logOut(){
    this._authService.signout()
  }
}
