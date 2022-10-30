import { SignUpComponent } from './modules/login-page/sign-up/sign-up.component';
import { MainPageComponent } from './modules/main-page/main-page/main-page.component';
import { LoginPageComponent } from './modules/login-page/login-page/login-page.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: "", redirectTo: "mainPage", pathMatch: "full" },
  { path: 'login', component: LoginPageComponent },
  { path: 'mainPage', component: MainPageComponent },
  { path: 'sign-up', component: SignUpComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
