using Microsoft.Maui.Controls;
using EcommerceApp.Services;
using EcommerceApp.Models;
using System.Collections.Generic;
using System.Linq;

namespace EcommerceApp;

public partial class FavoritesPage : ContentPage
{
    private FirebaseAuthService _authService;
    private FavoriteService _favoriteService;
    private List<Favorite> _favorites;

    public FavoritesPage(FirebaseAuthService authService)
    {
        InitializeComponent();
        _favorites = new List<Favorite>();
        _authService = authService;
    }

    private async Task LoadFavoritesAsync()
    {
        try
        {
            if (_authService.IsAuthenticated)
            {
                await _favoriteService.LoadFavoritesForCurrentUserAsync();
                _favorites = _favoriteService.GetFavorites();
            }
            else
            {
                _favorites = new List<Favorite>();
                await DisplayAlert("Authentication Required", "Please sign in to view your favorites", "OK");
                await Navigation.PopAsync();
                return;
            }
            
            UpdateFavoritesDisplay();
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", "Failed to load favorites", "OK");
            System.Diagnostics.Debug.WriteLine($"Error loading favorites: {ex.Message}");
        }
    }

    private void UpdateFavoritesDisplay()
    {
        if (_favorites.Any())
        {
            var displayItems = _favorites.Select(fav => new FavoriteDisplayItem
            {
                Id = fav.Id,
                ProductId = fav.ProductId,
                ProductName = fav.ProductName,
                Brand = "Lacoste",
                Color = "Light Orange",
                Size = "S",
                ImageUrl = fav.ImageUrl,
                Price = fav.Price
            }).ToList();
            FavoritesListView.ItemsSource = displayItems;
            FavoritesListView.IsVisible = true;
            EmptyFavoritesLayout.IsVisible = false;
        }
        else
        {
            FavoritesListView.IsVisible = false;
            EmptyFavoritesLayout.IsVisible = true;
        }
    }

    private async void OnRemoveFavoriteClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is FavoriteDisplayItem item)
        {
            var result = await DisplayAlert("Remove Favorite", $"Are you sure you want to remove {item.ProductName} from favorites?", "Yes", "No");
            if (result)
            {
                try
                {
                    await _favoriteService.RemoveFromFavoritesForCurrentUserAsync(item.ProductId);
                    await LoadFavoritesAsync();
                }
                catch (Exception ex)
                {
                    await DisplayAlert("Error", "Failed to remove favorite", "OK");
                    System.Diagnostics.Debug.WriteLine($"Error removing favorite: {ex.Message}");
                }
            }
        }
    }

    private async void OnAddToCartClicked(object sender, EventArgs e)
    {
        if (sender is Button button && button.CommandParameter is FavoriteDisplayItem item)
        {
            try
            {
                var cartService = Handler.MauiContext.Services.GetService<CartService>();
                if (cartService != null)
                {
                    await cartService.AddToCartForCurrentUserAsync(item.ProductId, item.ProductName, item.Price, item.ImageUrl);
                    await DisplayAlert("Success", $"{item.ProductName} added to cart!", "OK");
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", "Failed to add to cart", "OK");
                System.Diagnostics.Debug.WriteLine($"Error adding to cart: {ex.Message}");
            }
        }
    }

    private async void OnHomeClicked(object sender, EventArgs e)
    {
        await Navigation.PopToRootAsync();
    }

    private async void OnStoreClicked(object sender, EventArgs e)
    {
        await Navigation.PushAsync(new StorePage());
    }

    private async void OnFavoriteClicked(object sender, EventArgs e)
    {
        // Deja pe pagina de favorite
    }

    private async void OnCartClicked(object sender, EventArgs e)
    {
        var cartpg = App.ServiceProvider.GetRequiredService<CartPage>();
        await Navigation.PushAsync(cartpg);
    }

    private async void OnProfileClicked(object sender, EventArgs e)
    {
        var authService = (FirebaseAuthService)Handler.MauiContext.Services.GetService(typeof(FirebaseAuthService));
        await Navigation.PushAsync(new ProfilePage(authService));
    }

    private async void OnBackClicked(object sender, EventArgs e)
    {
        await Navigation.PopAsync();
    }

    public class FavoriteDisplayItem
    {
        public string Id { get; set; }
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public string Brand { get; set; }
        public string Color { get; set; }
        public string Size { get; set; }
        public string ImageUrl { get; set; }
        public double Price { get; set; }
    }
} 