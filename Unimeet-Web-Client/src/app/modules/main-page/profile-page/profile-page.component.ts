import { Component, OnInit } from '@angular/core';
import { PostService } from '../post.service';

@Component({
  selector: 'app-profile-page',
  templateUrl: './profile-page.component.html',
  styleUrls: ['./profile-page.component.scss'],
})
export class ProfilePageComponent implements OnInit {
  commandPopupVisible: boolean = false;
  postInfo: any;

  constructor(private postService: PostService) {}

  ngOnInit(): void {}
  posts = this.postService.getPosts();
  onCommandButtonClick() {
    this.commandPopupVisible = true;
  }
  onPopupHidden() {
    this.commandPopupVisible = false;
  }
  onPostInfo(postInfo: any) {
    this.postInfo = postInfo;
  }
}
