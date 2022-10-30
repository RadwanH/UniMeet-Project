import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.scss']
})
export class SignUpComponent implements OnInit {
  emailPattern: any = /\b(?:(?![_.-])(?!.*[_.-]{2})[a-z0-9_.-]+(?<![_.-]))@(?:(?!-)(?!.*--)[a-z0-9-]+(?<!-)\.)*edu\.tr\b/i;
  genders: string[] = ['Male', 'Female'];
  phoneNumberRules: any = { X: /[02-9]/ };
  constructor(private router: Router) { }

  ngOnInit(): void {
  }
  signUp(){

  }
  login(){
    this.router.navigateByUrl("/login");
  }
}
