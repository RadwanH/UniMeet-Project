import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PostAdditionComponent } from './post-addition.component';

describe('PostAdditionComponent', () => {
  let component: PostAdditionComponent;
  let fixture: ComponentFixture<PostAdditionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PostAdditionComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PostAdditionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
