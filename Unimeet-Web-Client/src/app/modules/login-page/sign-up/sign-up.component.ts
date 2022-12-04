import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { distinct, from, map } from 'rxjs';
import {
  ControllerService,
  DepartmentViewDto,
  UniDeptViewDto,
  UniViewDto,
} from 'src/app/typescript-angular-client';

@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.scss'],
})
export class SignUpComponent implements OnInit {
  emailPattern: any =
    /\b(?:(?![_.-])(?!.*[_.-]{2})[a-z0-9_.-]+(?<![_.-]))@(?:(?!-)(?!.*--)[a-z0-9-]+(?<!-)\.)*edu\.tr\b/i;
  genders: string[] = ['Male', 'Female'];
  phoneNumberRules: any = { X: /[02-9]/ };

  universities: UniViewDto[] = [];
  departments: DepartmentViewDto[] = [];

  firstName: string = '';
  lastName: string = '';
  userName: string = '';
  email: string = '';
  password: string = '';
  gender: string = '';
  phone: string = '';
  university: string = '';
  department: string = '';
  constructor(
    private router: Router,
    private unimeetService: ControllerService
  ) {}

  ngOnInit(): void {
    this.unimeetService
      .getUniDeptsUsingGET()
      .subscribe((unidept: UniDeptViewDto[]) => {
        unidept.forEach((unidept: UniDeptViewDto) => {
          if (
            !this.universities.find(
              (u) => u.uniName === unidept.uniViewDto?.uniName
            )
          ) {
            this.universities.push({
              uniID: unidept.uniViewDto?.uniID,
              uniName: unidept.uniViewDto?.uniName || '',
            });
          }
        });
      });
  }
  signUp() {
    this.unimeetService.createUserUsingPOST({
      firstName: this.firstName,
      lastName: this.lastName,
      userName: this.userName,
      email: this.email,
      password: this.password,
      gender: this.gender,
      phoneNumber: this.phone,
      userBio: 'bio',
      uniDept: {
        uniDeptId: 3,
        uniViewDto: {
          uniID: this.universities.find((u) => u.uniName === this.university)
            ?.uniID,
          uniName: this.university,
        },
        departmentViewDto: {
          deptId: this.departments.find((d) => d.deptName === this.department)
            ?.deptId,
          deptName: this.department,
        },
      },
    }).subscribe();
  }
  login() {
    this.router.navigateByUrl('/login');
  }
  universityValueChanged(event: any) {
    this.departments = [];
    this.department = '';
    this.unimeetService
      .getUniDeptsUsingGET()
      .subscribe((unidept: UniDeptViewDto[]) => {
        unidept.forEach((unidept: UniDeptViewDto) => {
          if (
            !this.departments.find(
              (u) => u.deptName === unidept.departmentViewDto?.deptName
            ) &&
            unidept.uniViewDto?.uniID === event.value.uniID
          ) {
            this.departments.push({
              deptId: unidept.departmentViewDto?.deptId,
              deptName: unidept.departmentViewDto?.deptName,
            });
          }
        });
      });
  }
}
