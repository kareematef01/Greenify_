import { DetailsDiagnosesComponent } from './pages/details_Diagnoses/details-diagnoses/details-diagnoses.component';
import { Routes } from '@angular/router';
import { NotfoundComponent } from './pages/notfound/notfound.component';
import { HomeComponent } from './pages/home/home.component';
import { authGuard } from './core/guard/auth.guard';
import { RegisterComponent } from './core/pages/register/register.component';
import { LoginComponent } from './core/pages/login/login.component';
import { ForgetPassComponent } from './core/pages/forget-pass/forget-pass.component';
import { SavedSearchComponent } from './pages/saved-search/saved-search.component';
import { SettingsComponent } from './pages/settings/settings.component';
import { authGuard2 } from './shared/guard/auth.guard';
import { DetailsComponent } from './pages/details/details.component';
import { ChatBotComponent } from './shared/layout/chat-bot/chat-bot.component';
import { DetailsIdentifyComponent } from './pages/details_Identify/details-identify/details-identify.component';

export const routes: Routes = [
    {path:'',redirectTo:"home",pathMatch:"full"},
    {path:"home",component:HomeComponent, canActivate:[authGuard]},
    {path:"savedSearch",component:SavedSearchComponent, canActivate:[authGuard]},
    {path:"settings",component:SettingsComponent, canActivate:[authGuard]},
    {path:"details",component:DetailsComponent, canActivate:[authGuard]},
    {path:"details-Diagnoses",component:DetailsDiagnosesComponent, canActivate:[authGuard]},
    {path:"details-Identify",component:DetailsIdentifyComponent, canActivate:[authGuard]},
    {path:"notFound",component:NotfoundComponent, canActivate:[authGuard]},
    {path:"register",component:RegisterComponent,canActivate:[authGuard2]},
    {path:"login",component:LoginComponent,canActivate:[authGuard2]},
    {path:"forgetpass",component:ForgetPassComponent,canActivate:[authGuard2]},
    {path:"chat-bot",component:ChatBotComponent,canActivate:[authGuard]},
    
    
    {path:"**",component:NotfoundComponent},
];
