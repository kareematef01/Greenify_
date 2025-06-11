import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { AuthService } from '../../core/services/auth/auth.service';
import { SavedSearchService } from '../../shared/services/SharedServices/saved-search-service.service';

@Component({
  selector: 'app-saved-search',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './saved-search.component.html',
  styleUrls: ['./saved-search.component.css']
})
export class SavedSearchComponent implements OnInit {
  savedPlants: { plantName: string; scientificName: string }[] = [];
  recentSearches: { plantName: string; scientificName: string }[] = [];

  constructor(
    private _authService: AuthService,
    private savedSearchService: SavedSearchService
  ) {}

  ngOnInit(): void {
    // Get saved plants and recent searches
    this.savedPlants = this.savedSearchService.getSavedPlants();
    this.recentSearches = this.savedSearchService.getRecentSearches();
  }

  deleteSavedPlant(index: number): void {
    this.savedPlants.splice(index, 1);
    this.savedSearchService.updateSavedPlants(this.savedPlants);
  }

  deleteRecentSearch(index: number): void {
    this.recentSearches.splice(index, 1);
    this.savedSearchService.updateRecentSearches(this.recentSearches);
  }

  logOut(): void {
    this._authService.signout();
  }
}
