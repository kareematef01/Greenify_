import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SearchService {

  constructor(private _HttpClient: HttpClient) { }

  plantSearch(plant: string): Observable<any> {
    return this._HttpClient.post("https://greenify-project-production.up.railway.app/api/plants/search", {
      query:plant
    })
  }
}