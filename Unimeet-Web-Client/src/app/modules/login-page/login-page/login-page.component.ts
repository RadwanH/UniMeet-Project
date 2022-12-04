import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {
  ControllerService,
  UserViewDTO,
} from 'src/app/typescript-angular-client';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrls: ['./login-page.component.scss'],
})
export class LoginPageComponent implements OnInit {
  emailPattern: any =
    /\b(?:(?![_.-])(?!.*[_.-]{2})[a-z0-9_.-]+(?<![_.-]))@(?:(?!-)(?!.*--)[a-z0-9-]+(?<!-)\.)*edu\.tr\b/i;
  constructor(
    private router: Router,
    private unimeetService: ControllerService
  ) {}
  users: UserViewDTO[] = [];
  emailValue: string = '';
  passwordValue: string = '';
  userId: number = 0;
  ngOnInit(): void {
    this.unimeetService.getUsersUsingGET().subscribe((data) => {
      this.users = data;
      console.log(this.users);
    });
  }
  login(): void {
    this.users.forEach((user)=>{
      if(user.email === this.emailValue && user.password === this.passwordValue){
        this.userId = 5;  //change when access id from userViewDto;

        this.router.navigateByUrl('/mainPage');
      }
    })
  }
  signUp() {
    this.router.navigateByUrl('/sign-up');
  }
}
