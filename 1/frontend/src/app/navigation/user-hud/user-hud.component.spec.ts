import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserHudComponent } from './user-hud.component';

describe('UserHudComponent', () => {
  let component: UserHudComponent;
  let fixture: ComponentFixture<UserHudComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserHudComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserHudComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
