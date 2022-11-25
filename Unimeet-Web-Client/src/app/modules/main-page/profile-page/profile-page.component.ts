import { post } from './../../../models/post';
import { Component, OnInit } from '@angular/core';
import { PostService } from '../post.service';

@Component({
  selector: 'app-profile-page',
  templateUrl: './profile-page.component.html',
  styleUrls: ['./profile-page.component.scss'],
})
export class ProfilePageComponent implements OnInit {
  postPopupVisible: boolean = false;
  postInfo: any;

  constructor(private postService: PostService) {}

  ngOnInit(): void {}
  posts = this.postService.getPosts();

  onPopupHidden() {
    this.postPopupVisible = false;
  }
  onClickProfile(post: any) {
    this.postInfo = post;
    this.postPopupVisible = true;
  }
}
