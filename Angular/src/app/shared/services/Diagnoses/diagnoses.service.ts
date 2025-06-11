import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DiagnosesService {

  private diagnosisResult: any; // استخدم any هنا بدل الواجهة
  private uploadedImageUrl: string | null = null;

  constructor(private _HttpClient: HttpClient) { }

  getDiagnoses(file: File): Observable<any> {
    const formData = new FormData();
    formData.append('Image', file);

    this.uploadedImageUrl = URL.createObjectURL(file);

    return this._HttpClient.post<any>(
      "https://greenify-project-production.up.railway.app/api/plants/analyze-image",
      formData
    );
  }

  setDiagnosisResult(result: any): void {
    this.diagnosisResult = result;
  }

  getDiagnosisResult(): any {
    return this.diagnosisResult;
  }

  getUploadedImageUrl(): string | null {
    return this.uploadedImageUrl;
  }
}