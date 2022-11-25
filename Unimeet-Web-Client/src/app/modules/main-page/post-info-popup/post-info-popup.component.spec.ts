import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PostInfoPopupComponent } from './post-info-popup.component';

describe('PostInfoPopupComponent', () => {
  let component: PostInfoPopupComponent;
  let fixture: ComponentFixture<PostInfoPopupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PostInfoPopupComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PostInfoPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
