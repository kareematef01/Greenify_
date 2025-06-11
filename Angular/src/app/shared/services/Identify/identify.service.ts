import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class IdentifyService {

  private identifyResult: any; // استخدم any هنا بدل الواجهة
  private uploadedImageUrl: string | null = null;

  constructor(private _HttpClient: HttpClient) { }

  getIdentify(file: File): Observable<any> {
    const formData = new FormData();
    formData.append('Image', file);

    this.uploadedImageUrl = URL.createObjectURL(file);

    return this._HttpClient.post<any>(
      "https://greenify-project-production.up.railway.app/api/plants/identify-plant",
      formData
    );
  }

  setIdentifyResult(result: any): void {
    this.identifyResult = result;
  }

  getIdentifyResult(): any {
    return this.identifyResult;
  }

  getUploadedImageUrl(): string | null {
    return this.uploadedImageUrl;
  }
}