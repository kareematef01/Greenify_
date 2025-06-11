import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GoogleGenerativeAI } from '@google/generative-ai';

@Injectable({
  providedIn: 'root'
})
export class GeminiService {

  private API_KEY = 'AIzaSyBI2R8E58WyRi3v07vm1WqRiHQdzA_7ucM'; // ضع مفتاح API هنا
  private API_URL = `https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=${this.API_KEY}`;

  constructor(private http: HttpClient) {}

  generateText(prompt: string): Observable<any> {
    const payload = {
      contents: [{ role: 'user', parts: [{ text: prompt }] }],
    };

    return this.http.post(this.API_URL, payload);
  }

  // getGeminiResponse(prompt: string): Observable<any> {
  //   const body = {
  //     contents: [{ parts: [{ text: prompt }] }] // ✅ التصحيح هنا
  //   };

  //   return this.http.post<any>(this.apiUrl, body);
  // }
}
