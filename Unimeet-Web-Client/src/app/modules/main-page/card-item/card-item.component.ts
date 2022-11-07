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
  popupVisible: boolean = true;
  positionOf: string = '';
  @Input() post:any;
  @Input() showCommandPopup: any;
  @Output() onCommandButtonClick = new EventEmitter
  constructor() {}

  ngOnInit(): void {}

  likeButtonClick(){
    this.isLikeClicked = !this.isLikeClicked;
  }
  showAllComments(id: any){
    this.positionOf = `#post${id}`;
  }
  showAllCommentsClick(){
    this.onCommandButtonClick.emit();
  }
}
