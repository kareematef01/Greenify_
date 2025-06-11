import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class SavedSearchService {
  private savedKey = 'savedPlants';
  private recentKey = 'recentPlants';

  // Saved Plants Logic
  getSavedPlants(): { plantName: string; scientificName: string }[] {
    const data = localStorage.getItem(this.savedKey);
    return data ? JSON.parse(data) : [];
  }

  savePlant(plant: { plantName: string; scientificName: string }): void {
    const current = this.getSavedPlants();
    current.push(plant);
    localStorage.setItem(this.savedKey, JSON.stringify(current));
  }

  updateSavedPlants(plants: { plantName: string; scientificName: string }[]): void {
    localStorage.setItem(this.savedKey, JSON.stringify(plants));
  }

  clearSavedPlants(): void {
    localStorage.removeItem(this.savedKey);
  }

  // Recent Searches Logic
  getRecentSearches(): { plantName: string; scientificName: string }[] {
    const data = localStorage.getItem(this.recentKey);
    return data ? JSON.parse(data) : [];
  }

  addToRecentSearches(plant: { plantName: string; scientificName: string }): void {
    let recent = this.getRecentSearches();
    recent = recent.filter(p => p.plantName !== plant.plantName); // remove duplicates
    recent.unshift(plant); // add to top
    if (recent.length > 10) {
      recent.pop(); // limit to 10 items
    }
    localStorage.setItem(this.recentKey, JSON.stringify(recent));
  }

  updateRecentSearches(plants: { plantName: string; scientificName: string }[]): void {
    localStorage.setItem(this.recentKey, JSON.stringify(plants));
  }

  clearRecentSearches(): void {
    localStorage.removeItem(this.recentKey);
  }
}
