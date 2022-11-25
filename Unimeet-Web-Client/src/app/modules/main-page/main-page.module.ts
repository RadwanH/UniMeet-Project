import { DxButtonModule, DxPopupModule, DxScrollViewModule } from 'devextreme-angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MainPageComponent } from './main-page/main-page.component';
import { FontAwesomeModule } from "@fortawesome/angular-fontawesome";
import { CardItemComponent } from './card-item/card-item.component';
import { ShowCommentsPopupComponent } from './show-comments-popup/show-comments-popup.component';
import { ProfilePageComponent } from './profile-page/profile-page.component';
import { PostInfoPopupComponent } from './post-info-popup/post-info-popup.component';


@NgModule({
  declarations: [
    MainPageComponent,
    CardItemComponent,
    ShowCommentsPopupComponent,
    ProfilePageComponent,
    PostInfoPopupComponent
  ],
  imports: [
    CommonModule,
    DxButtonModule,
    FontAwesomeModule,
    DxPopupModule,
    DxScrollViewModule
  ]
})
export class MainPageModule { }
