import { MainPageComponent } from './modules/main-page/main-page/main-page.component';
import { LoginPageComponent } from './modules/login-page/login-page/login-page.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: 'login', component: LoginPageComponent },
  { path: 'mainPage', component: MainPageComponent, pathMatch: 'full' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
