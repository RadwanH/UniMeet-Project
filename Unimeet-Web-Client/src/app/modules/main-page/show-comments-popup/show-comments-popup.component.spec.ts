import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ShowCommentsPopupComponent } from './show-comments-popup.component';

describe('ShowCommentsPopupComponent', () => {
  let component: ShowCommentsPopupComponent;
  let fixture: ComponentFixture<ShowCommentsPopupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ShowCommentsPopupComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ShowCommentsPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
