import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LoginPageComponent } from './login-page/login-page.component';
import { DxButtonModule, DxFormModule, DxTextBoxModule, DxValidatorModule } from 'devextreme-angular';

@NgModule({
  declarations: [
    LoginPageComponent
  ],
  imports: [
    CommonModule,
    DxFormModule,
    DxTextBoxModule,
    DxValidatorModule,
    DxButtonModule
  ],
  exports:[
    LoginPageComponent
  ]
})
export class LoginPageModule { }
