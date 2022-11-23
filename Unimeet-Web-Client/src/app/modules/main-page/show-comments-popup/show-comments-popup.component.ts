import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-show-comments-popup',
  templateUrl: './show-comments-popup.component.html',
  styleUrls: ['./show-comments-popup.component.scss'],
})
export class ShowCommentsPopupComponent implements OnInit {
  @Input() showCommentPopup: any;
  @Input() positionOf: any;
  @Input() postInfo:any;
  @Output() popupHidden = new EventEmitter();
  constructor() {}

  ngOnInit(): void {}

  popupOnHidden() {
    this.popupHidden.emit();
  }
}
