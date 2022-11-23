import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { faHeart } from '@fortawesome/free-solid-svg-icons';
import { faComment } from '@fortawesome/free-regular-svg-icons';

@Component({
  selector: 'app-card-item',
  templateUrl: './card-item.component.html',
  styleUrls: ['./card-item.component.scss']
})
export class CardItemComponent implements OnInit {
  faHeart = faHeart;
  faComment = faComment;
  isLikeClicked: boolean = false;
  @Input() post:any;
  @Output() onCommandButtonClick = new EventEmitter();
  @Output() positionOf = new EventEmitter();
  @Output() postInfo = new EventEmitter();
  constructor() {}

  ngOnInit(): void {}

  likeButtonClick(){
    this.isLikeClicked = !this.isLikeClicked;
  }
  showAllComments(id: any){
    this.positionOf.emit(`#post${id}`);
  }
  showAllCommentsClick(post:any){
    this.onCommandButtonClick.emit();
    this.postInfo.emit(post);
  }
}
