import { SearchService } from './../../shared/services/search/search.service';
import { Component, HostListener } from '@angular/core';
import { RouterLink, RouterLinkActive, Router } from '@angular/router';
import { GeminiService } from '../../shared/services/gemini/gemini.service';
import { NgClass, NgFor, NgIf } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ChatBotComponent } from "../../shared/layout/chat-bot/chat-bot.component";
import { Plants, Result } from '../../shared/interfaces/plants';
import { SavedSearchService } from '../../shared/services/SharedServices/saved-search-service.service';
import { DiagnosesService } from '../../shared/services/Diagnoses/diagnoses.service';
import { Diagnoses } from '../../shared/interfaces/diagnoses';
import { IdentifyService } from '../../shared/services/Identify/identify.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterLink, NgIf, FormsModule, ChatBotComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  prompt: string = '';
  plantSearch!: Plants;
  isLoading: boolean = false;
  isLoading2: boolean = false;
  showChatBot: boolean = false;
  message: string = '';
  message2: string = '';

  // ✅ تشخيص النبات
  selectedFile!: File;

  constructor(
    private aiService: GeminiService,
    private _SearchService: SearchService,
    private _savedSearchService: SavedSearchService,
    private _router: Router,
    private _diagnosesService: DiagnosesService,
    private _IdentifyService:IdentifyService // ✅ إضافة السيرفيس الجديد
  ) {}

  // 🔍 البحث بالنص
  getSearchPlant() {
    if (!this.prompt.trim()) return;

    this.isLoading = true;
    this._SearchService.plantSearch(this.prompt).subscribe({
      next: (res) => {
        this.isLoading = false;
        this.plantSearch = res;

        if (res.results && res.results.length > 0) {
          const firstResult = res.results[0];
          this._savedSearchService.addToRecentSearches({
            plantName: firstResult.plantName,
            scientificName: firstResult.scientificName
          });
          this._router.navigate(['/details'], {
            state: { plant: firstResult }
          });
        } else {
          this.message = 'There is no plant with this name.!';
          setTimeout(() => {
            this.message = '';
          }, 3000);
        }
      },
      error: (err) => {
        console.error(err);
        this.isLoading = false;
      }
    });
  }

  // 🤖 فتح الشات
  showChat(event: Event) {
    event.stopPropagation();
    this.showChatBot = !this.showChatBot;
  }

  @HostListener('document:click', ['$event'])
  onClickOutside(event: Event) {
    if (!(event.target as HTMLElement).closest('.chat-container') && !(event.target as HTMLElement).closest('.chatbot')) {
      this.showChatBot = false;
    }
  }

  // ✅ ← تشخيص النبات: تحميل الصورة
  onImageSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input?.files && input.files.length > 0) {
      this.selectedFile = input.files[0];
    }
  }

  // ✅ ← رفع الصورة والتشخيص
  diagnose(): void {
    if (!this.selectedFile) {
      alert('من فضلك اختر صورة أولاً');
      return;
    }

    this.isLoading = true;

    this._diagnosesService.getDiagnoses(this.selectedFile).subscribe({
      next: (data: Diagnoses) => {
        this._diagnosesService.setDiagnosisResult(data); // تخزين النتيجة مؤقتًا
        this.isLoading = false;
        this._router.navigate(['/details-Diagnoses']);
      },
      error: (err) => {
        this.message = 'This photo cannot be identified.!';
        setTimeout(() => {
            this.message = '';
          }, 3000);
        console.error('خطأ أثناء التشخيص:', err);
        this.isLoading = false;
      }
    });
  }

  Identify(): void {
    if (!this.selectedFile) {
      alert('من فضلك اختر صورة أولاً');
      return;
    }

    this.isLoading2 = true;

    this._IdentifyService.getIdentify(this.selectedFile).subscribe({
      next: (data: Diagnoses) => {
        this._IdentifyService.setIdentifyResult(data); // تخزين النتيجة مؤقتًا
        this.isLoading2 = false;
        this._router.navigate(['/details-Identify']);
      },
      error: (err) => {
        this.message2 = 'This photo cannot be identified.!';
        setTimeout(() => {
            this.message2 = '';
          }, 3000);
        console.error('خطأ أثناء التشخيص:', err);
        this.isLoading2 = false;
      }
    });
  }
}



