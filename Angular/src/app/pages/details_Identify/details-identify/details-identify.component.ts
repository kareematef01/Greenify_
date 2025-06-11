import { NgFor, NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { SavedSearchService } from '../../../shared/services/SharedServices/saved-search-service.service';
import { ActivatedRoute, Router } from '@angular/router';
import { IdentifyService } from '../../../shared/services/Identify/identify.service';

@Component({
  selector: 'app-details-identify',
  standalone: true,
  imports: [NgIf, NgFor], // ← ضيف NgIf هنا
  templateUrl: './details-identify.component.html',
  styleUrl: './details-identify.component.css'
})
export class DetailsIdentifyComponent {
  identifyData: any;
  imageUrl: string | null = null;

  constructor(private IdentifyService: IdentifyService, private savedSearchService: SavedSearchService, private router: Router, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.identifyData = this.IdentifyService.getIdentifyResult();
    this.imageUrl = this.IdentifyService.getUploadedImageUrl();

    if (!this.identifyData) {
      // لو مفيش بيانات، ممكن ترجع المستخدم أو تعرض رسالة
      console.warn("No Identify data found.");
    }
  }

  savePlant() {
    this.savedSearchService.savePlant({
      plantName: this.identifyData.identifiedName,
      scientificName: this.identifyData.details.scientificName
    });

    this.router.navigate(['/savedSearch']);
  }
}
