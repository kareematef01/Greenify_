import { Component, OnInit } from '@angular/core';
import { DiagnosesService } from '../../../shared/services/Diagnoses/diagnoses.service';
import { NgIf } from '@angular/common';
import { SavedSearchService } from '../../../shared/services/SharedServices/saved-search-service.service';
import { ActivatedRoute, Router } from '@angular/router';


@Component({
  selector: 'app-details-diagnoses',
  standalone: true,
  imports: [NgIf], // ← ضيف NgIf هنا
  templateUrl: './details-diagnoses.component.html',
  styleUrls: ['./details-diagnoses.component.css']
})
export class DetailsDiagnosesComponent implements OnInit {

  diagnosisData: any;
  imageUrl: string | null = null;

  constructor(private diagnosesService: DiagnosesService, private savedSearchService:SavedSearchService, private router: Router, private route: ActivatedRoute) {}

  ngOnInit(): void {
    this.diagnosisData = this.diagnosesService.getDiagnosisResult();
    this.imageUrl = this.diagnosesService.getUploadedImageUrl();

    if (!this.diagnosisData) {
      // لو مفيش بيانات، ممكن ترجع المستخدم أو تعرض رسالة
      console.warn("No diagnosis data found.");
    }
  }

  savePlant() {
    this.savedSearchService.savePlant({
      plantName: this.diagnosisData.plantName,
      scientificName: this.diagnosisData.status
    });

    this.router.navigate(['/savedSearch']);
  }
}
