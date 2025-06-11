import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { Result } from '../../shared/interfaces/plants'; // تأكد من المسار الصحيح
import { SavedSearchService } from '../../shared/services/SharedServices/saved-search-service.service';

@Component({
  selector: 'app-details',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.css']
})
export class DetailsComponent {
  plantData!: Result;
  

  constructor(private router: Router, private route: ActivatedRoute, private savedSearchService: SavedSearchService) {
    const navigation = this.router.getCurrentNavigation();
    const state = navigation?.extras?.state as { plant: Result };

    if (state?.plant) {
      this.plantData = state.plant;
    } else {
      // رجع المستخدم للصفحة الرئيسية لو مفيش داتا
      this.router.navigate(['/']);
    }
  }

  savePlant() {
    this.savedSearchService.savePlant({
      plantName: this.plantData.plantName,
      scientificName: this.plantData.scientificName
    });

    this.router.navigate(['/savedSearch']);
  }
}
