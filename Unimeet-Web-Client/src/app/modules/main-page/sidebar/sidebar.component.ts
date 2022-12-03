import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { faHouse, faMessage, faPlus, faSearch, faUser } from '@fortawesome/free-solid-svg-icons';



@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent implements OnInit {
 faHouse= faHouse ;
 faProfile = faUser;
 faSearch = faSearch;
 faMessage = faMessage;
 faPlus = faPlus;
 addPostPopupVisible: boolean = false;

  constructor(private router: Router ) { }

  ngOnInit(): void {
  }

  onHomeClick() {
    this.router.navigate([''])
  }
  onProfileClick() {
    this.router.navigate(['/profile-page'])
  }

  createPost() {
    this.addPostPopupVisible = true;
  }
  onPopupHidden() {
    this.addPostPopupVisible = false;
  }

}
