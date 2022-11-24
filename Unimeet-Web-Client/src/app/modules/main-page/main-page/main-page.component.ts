import { PostService } from './../post.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-main-page',
  templateUrl: './main-page.component.html',
  styleUrls: ['./main-page.component.scss'],
})
export class MainPageComponent implements OnInit {
  commandPopupVisible: boolean = false;
  positionOf: string = '';
  postInfo: any;
  constructor(private postService: PostService) {}

  ngOnInit(): void {}
  posts = this.postService.getPosts();
  onCommandButtonClick() {
    this.commandPopupVisible = true;
  }
  onPositionOfClick(position: string) {
    this.positionOf = position;
  }
  onPopupHidden() {
    this.commandPopupVisible = false;
  }
  onPostInfo(postInfo: any) {
    this.postInfo = postInfo;
  }
}
