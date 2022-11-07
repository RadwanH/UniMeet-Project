import { PostService } from './../post.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-main-page',
  templateUrl: './main-page.component.html',
  styleUrls: ['./main-page.component.scss'],
})
export class MainPageComponent implements OnInit {
  commandPopupVisible: boolean = false;
  constructor(private postService: PostService) {}

  ngOnInit(): void {}
  posts = this.postService.getPosts();
  onCommandButtonClick(){
    this.commandPopupVisible = true;
  }
  fakePosts: any[] = [
    {
      id: 1,
      image: 'https://fakeimg.pl/440x320/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
    {
      id: 1,
      image: 'https://fakeimg.pl/200x100/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
    {
      id: 1,
      image: 'https://fakeimg.pl/200x200/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
    {
      id: 1,
      image: 'https://fakeimg.pl/440x320/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
    {
      id: 1,
      image: 'https://fakeimg.pl/440x320/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
    {
      id: 1,
      image: 'https://fakeimg.pl/440x320/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
    {
      id: 1,
      image: 'https://fakeimg.pl/440x320/282828/eae0d0/?retina=1',
      content: ['', ''],
      username: '',
      numberOfLikes: 5,
      numberOfComments: 10,
    },
  ];
}
