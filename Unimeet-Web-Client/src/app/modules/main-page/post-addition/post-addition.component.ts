import { Component, enableProdMode, EventEmitter, Input, OnInit, Output } from '@angular/core';

if (!/localhost/.test(document.location.host)) {
  enableProdMode();
}

@Component({
  selector: 'app-post-addition',
  templateUrl: './post-addition.component.html',
  styleUrls: ['./post-addition.component.scss'],

})
export class PostAdditionComponent implements OnInit {
  @Input() addPostPopupVisible: any;
  @Output() popupHidden = new EventEmitter();
  isDropZoneActive = false;

  imageSource = '';

  textVisible = true;

  progressVisible = false;

  progressValue = 0;

  value: [] = [];


  constructor() {
    this.onDropZoneEnter = this.onDropZoneEnter.bind(this);
    this.onDropZoneLeave = this.onDropZoneLeave.bind(this);
    this.onUploaded = this.onUploaded.bind(this);
    this.onProgress = this.onProgress.bind(this);
    this.onUploadStarted = this.onUploadStarted.bind(this);


  }

  ngOnInit(): void {
  }



  popupOnHidden() {
    this.popupHidden.emit();
  }
  onDropZoneEnter(e: any) {
    if (e.dropZoneElement.id === 'dropzone-external') { this.isDropZoneActive = true; }
  }

  onDropZoneLeave(e: any) {
    if (e.dropZoneElement.id === 'dropzone-external') { this.isDropZoneActive = false; }
  }

  onUploaded(e: any) {
    const file = e.file;
    const fileReader = new FileReader();
    fileReader.onload = () => {
      this.isDropZoneActive = false;
      this.imageSource = fileReader.result as string;
    };
    fileReader.readAsDataURL(file);
    this.textVisible = false;
    this.progressVisible = false;
    this.progressValue = 0;
    console.log(this.value)
  }

  onProgress(e: any) {
    this.progressValue = e.bytesLoaded / e.bytesTotal * 100;
  }

  onUploadStarted(e: any) {
    this.imageSource = '';
    this.progressVisible = true;
  }

}
