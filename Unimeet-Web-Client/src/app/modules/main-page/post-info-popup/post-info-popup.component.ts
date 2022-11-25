import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { faHeart, faXmark } from '@fortawesome/free-solid-svg-icons';
import { faComment } from '@fortawesome/free-regular-svg-icons';

@Component({
  selector: 'app-post-info-popup',
  templateUrl: './post-info-popup.component.html',
  styleUrls: ['./post-info-popup.component.scss']
})
export class PostInfoPopupComponent implements OnInit {
  faHeart = faHeart;
  faComment = faComment;
  isLikeClicked: boolean = false;
  @Input() showPostInfoPopup: any;
  @Input() postInfo:any;
  @Output() popupHidden = new EventEmitter();
  constructor() {}

  ngOnInit(): void {}
  likeButtonClick(){
    this.isLikeClicked = !this.isLikeClicked;
  }
  popupOnHidden() {
    this.popupHidden.emit();
  }
  popupCloseButton(){
    this.popupHidden.emit();
  }

}
