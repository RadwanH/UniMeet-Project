import { DxButtonModule, DxFileUploaderModule, DxPopupModule, DxProgressBarModule, DxScrollViewModule, DxTextAreaModule } from 'devextreme-angular';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MainPageComponent } from './main-page/main-page.component';
import { FontAwesomeModule } from "@fortawesome/angular-fontawesome";
import { CardItemComponent } from './card-item/card-item.component';
import { ShowCommentsPopupComponent } from './show-comments-popup/show-comments-popup.component';
import { ProfilePageComponent } from './profile-page/profile-page.component';
import { PostInfoPopupComponent } from './post-info-popup/post-info-popup.component';
import { SidebarComponent } from './sidebar/sidebar.component';
import { PostAdditionComponent } from './post-addition/post-addition.component';
import { BrowserModule } from '@angular/platform-browser';


@NgModule({
  declarations: [
    MainPageComponent,
    CardItemComponent,
    ShowCommentsPopupComponent,
    ProfilePageComponent,
    PostInfoPopupComponent,
    SidebarComponent,
    PostAdditionComponent
  ],
  imports: [
    CommonModule,
    DxButtonModule,
    FontAwesomeModule,
    DxPopupModule,
    DxScrollViewModule,
    DxFileUploaderModule,
    BrowserModule,
    DxProgressBarModule,
    DxTextAreaModule

  ]
})
export class MainPageModule { }
