import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class PostService {
  posts: any[] = [
    {
      postId: 1,
      image: 'https://fakeimg.pl/440x320/282828/eae0d0/?retina=1',
      user: {
        userId: 1,
        name: 'name1',
        surname: 'surname1',
        username: 'username1',
        email: 'email1',
      },
      content: 'content1',
      numberOfLikes: 5,
      numberOfComments: 10,
      comments: [
        {
          commentId: 1,
          userId: 1,
          username: 'username1',
          postId: 1,
          content: 'commentContent1',
        },
        {
          commentId: 2,
          userId: 1,
          username: 'username1',
          postId: 1,
          content: 'commentContent2',
        },
        {
          commentId: 3,
          userId: 1,
          username: 'username1',
          postId: 1,
          content: 'commentContent3',
        },
        {
          commentId: 4,
          userId: 2,
          username: 'username2',
          postId: 1,
          content: 'commentContent4',
        },
        {
          commentId: 5,
          userId: 2,
          username: 'username2',
          postId: 1,
          content: 'commentContent5',
        },
        {
          commentId: 6,
          userId: 2,
          username: 'username2',
          postId: 1,
          content: 'commentContent6',
        },
        {
          commentId: 7,
          userId: 2,
          username: 'username2',
          postId: 1,
          content: 'commentContent7',
        },
        {
          commentId: 8,
          userId: 3,
          username: 'username3',
          postId: 1,
          content: 'commentContent8',
        },
        {
          commentId: 9,
          userId: 3,
          username: 'username3',
          postId: 1,
          content: 'commentContent9',
        },
        {
          commentId: 10,
          userId: 3,
          username: 'username3',
          postId: 1,
          content: 'commentContent10',
        },
      ],
    },
    {
      postId: 2,
      image: 'https://fakeimg.pl/200x100/282828/eae0d0/?retina=1',
      user: {
        userId: 2,
        name: 'name2',
        surname: 'surname2',
        username: 'username2',
        email: 'email2',
      },
      content: 'content2',
      numberOfLikes: 10,
      numberOfComments: 5,
      comments: [
        {
          commentId: 11,
          userId: 2,
          username: 'username2',
          postId: 2,
          content: 'commentContent11',
        },
        {
          commentId: 12,
          userId: 1,
          username: 'username1',
          postId: 2,
          content: 'commentContent12',
        },
        {
          commentId: 13,
          userId: 2,
          username: 'username2',
          postId: 2,
          content: 'commentContent13',
        },
        {
          commentId: 14,
          userId: 2,
          username: 'username2',
          postId: 2,
          content: 'commentContent14',
        },
        {
          commentId: 15,
          userId: 3,
          username: 'username3',
          postId: 2,
          content: 'commentContent15',
        },
      ],
    },
    {
      postId: 3,
      image: 'https://fakeimg.pl/200x200/282828/eae0d0/?retina=1',
      user: {
        userId: 3,
        name: 'name3',
        surname: 'surname3',
        username: 'username3',
        email: 'email3',
      },
      content: 'content3',
      numberOfLikes: 12,
      numberOfComments: 4,
      comments: [
        {
          commentId: 16,
          userId: 3,
          username: 'username3',
          postId: 3,
          content: 'commentContent16',
        },
        {
          commentId: 17,
          userId: 3,
          username: 'username3',
          postId: 3,
          content: 'commentContent17',
        },
        {
          commentId: 18,
          userId: 2,
          username: 'username2',
          postId: 3,
          content: 'commentContent18',
        },
        {
          commentId: 19,
          userId: 2,
          username: 'username2',
          postId: 3,
          content: 'commentContent19',
        },
      ],
    },
  ];
  constructor() {}

  getPosts() {
    return this.posts;
  }
}
