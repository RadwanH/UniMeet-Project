import { DxButtonModule, DxPopupModule } from 'devextreme-angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MainPageComponent } from './main-page/main-page.component';
import { FontAwesomeModule } from "@fortawesome/angular-fontawesome";
import { CardItemComponent } from './card-item/card-item.component';


@NgModule({
  declarations: [
    MainPageComponent,
    CardItemComponent
  ],
  imports: [
    CommonModule,
    DxButtonModule,
    FontAwesomeModule,
    DxPopupModule
  ]
})
export class MainPageModule { }
